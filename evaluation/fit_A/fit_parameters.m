%! before running this code, please add all subfolders into path
clear

% this is a full size KC model, it will take about 60 min to run the code
% below, ~50s per odor, which is not too bad.
% construct PN-KC connectivity

% prameters 
odor_N = 110;
PN_N = 23; 
KC_d = [45,45];
KC_input_N = 6;
total_T = 2500;
deltat = 0.5;

taus = 50;
gsyn = 0;

% ihibition connectivity matrix
[W] = ConnectivityMatrix(KC_d);
% full random connectivity mode 
w_matrix = PN_KC_connect(PN_N,KC_d,KC_input_N,"full random",1,false);

% load PN responses
load("odor_PN_t.mat")

% ------------------ fitting input scaling factor--------------------------

% odors to be fitted
odor_set = 1:15:odor_N;
% parameter to be fitted
A_range = linspace(0.004,0.007,8);

% place holder for evaluation
sparseness = zeros(length(odor_N), length(A_range));
fraction = zeros(length(odor_N), length(A_range));
response_counts = zeros(length(odor_N), length(A_range),KC_d(1)*KC_d(2));


for A_i = 1: length(A_range)
    fprintf('Starting simulate with A as: %d\n', A_range(A_i));
    odor_responses = zeros(length(odor_set), KC_d(1)*KC_d(2));
    tic
    for odorID_i = 1: length(odor_set)
        % temp parameters
        A = A_range(A_i); % to be updated
        
        % generate input from PN
        test_odor =squeeze(odor_PN_t(odor_set(odorID_i),:,:));
        fprintf('Current testing odor: %d\n', odor_set(odorID_i));
        %test_odor = test_odor(1:PN_N, :);
        KC_input = zeros(KC_d(1), KC_d(2), total_T);

        for i = 1:KC_d(1)
            KC_input(i,:,:) = A*squeeze(w_matrix(i,:,:))*test_odor;
        end
            
        % simulate KC responses to one odor
        
        [spiketimes]=LIF2D_simple_network(KC_d,W,gsyn,taus,KC_input);
        if ~isempty(spiketimes)
            [sck, f_kc, counts] = Sparsity(spiketimes,KC_d); % sparsness
            disp(['Sparsness: ' num2str(sck)]);
            disp(['Responding frection: ' num2str(f_kc*100)]);
            sparseness(odorID_i,A_i) = sck;
            fraction(odorID_i,A_i) = f_kc;
            response_counts(odorID_i,A_i,:) = counts;
        end
    end
    toc
%     odor_corr = corrcoef(odor_responses');
%     inter_odor_corr(1,A_i) = mean(odor_corr(triu(ones(size(odor_corr)),1)>0));
end
sparseness(sparseness == 0) = 1;
save('sparseness_new.mat', 'sparseness');
save('fraction_new.mat', 'fraction');
save('response_counts_new.mat', 'response_counts');

load("fraction_new.mat")


% plot the sparsness v.s. A
figure(1)
hold on
plot(A_range,sparseness', '--','LineWidth',2)
plot(A_range,mean(sparseness,1),'LineWidth',4)
xlabel('A value')
ylabel('sparseness')
title('sparseness v.s. A')
legend('Odor 1', 'Odor 16', 'Odor 31', 'Odor 46', 'Odor 61','Odor 76', ...
    'Odor 91','Odor 106','average')
hold off

% plot the responding fraction v.s. A
figure(2)
hold on
plot(A_range,fraction', '--','LineWidth',2)
plot(A_range,mean(fraction,1),'LineWidth',4)
xline(0.005,'LineWidth',2)
xlabel('A value')
ylabel('responding KC fraction')
title('responding KC fraction v.s. A')
legend('Odor 1', 'Odor 16', 'Odor 31', 'Odor 46', 'Odor 61','Odor 76', ...
    'Odor 91','Odor 106','average')
hold off