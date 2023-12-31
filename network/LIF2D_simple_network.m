function [spiketimes]=LIF2D_simple_network(KC_d,W,gsyn,taus,KC_data)
%RUN by entering the following at the matlab command window prompt:
%  [spiketimes]=LIF2D_simple_network(n,W,gsyn,taus);

n = KC_d(1)*KC_d(2);
total_T = size(KC_data, 3);
% Set model parameter values
a=0.02;
b=0.2;
c=-65;
d=8;
vthresh=30;

rng(100);

% % from KC model
Iapp = reshape(KC_data, n, total_T);

% %  constant applied current
% Iapp = 4*ones(n,total_T);

% % values alternate between high and low current
% i1 = 4.5; i2 = 3.8;
% values = [i1 i2; i2 i1;]';
% Iapp = repmat(values, ceil(KC_d(1)/2), ceil(KC_d(2)/2), total_T); % + 0.1*rand(n,total_T);
% Iapp = reshape(Iapp, n, []);

% randomly turn off input to 50 neurons
% turnoff_indx = randi([1, 100], 1, 50);
% Iapp(turnoff_indx) = 0;

% % % % cell 10 Iapp = 4, all others Iapp = 2
% Iapp = 2*ones(n,1);
% Iapp(10)=4;

% figure(1)
% Iapp_1 = reshape(max(Iapp, [], 2), KC_d(1), KC_d(2));
% imagesc(Iapp_1);
% clim([0, max(Iapp_1(:))]);
% colormap(pink);
% colorbar;
% xlabel('KC neuron x');
% ylabel('KC neuron y');
% title('KC input');

% figure(1)
% imagesc(Iapp);
% colormap(pink);
% colorbar;
% xlabel('Timesteps');
% ylabel('KC index');
% title('KC input');

% pulse of applied current
% ton=20;
% toff=30;
% pulsei=6;

%Set initial values for v & u
% same initial conditions
v=-65*ones(n,1);
u=-12*ones(n,1);
s=zeros(n,1);

% %Set initial values for v & u
% % random initial conditions
% v=-70*ones(n,1) + 10*rand(n,1);
% u=-14*ones(n,1) + 5*rand(n,1);
% s=zeros(n,1);
% % % linearly spaced initial conditions
% v=-70*ones(n,1) + linspace(-10,8,n)';
% u=-14*ones(n,1) + linspace(1,7,n)';
% s=zeros(n,1);
% % initial conditions for 2 clusters
% v=-17*ones(n,1);
% u=-14*ones(n,1);
% v(n/2:end)=v(n/2:end)+10;
% u(n/2:end)=u(n/2:end)+5;
% s=zeros(n,1);

% set time of simulation = tend, time step = deltat, and number of
% solution points computed totalpts
deltat=0.5;
totalpts=total_T;

% initialize storage vector 
%v_tot=zeros(totalpts,2);
%u_tot=zeros(totalpts,2);
%s_tot=zeros(totalpts,2);

spiketimes=[];
%spiketimes=zeros(n*totalpts,2);
%k=1;

% store initial values
%v_tot(1,:)=v';
%u_tot(1,:)=u';

hbar = waitbar(0, 'Running...'); % Create the progress bar

% step through time to compute solution
for i=2:totalpts
    t=i*deltat;
    
    % uncomment if applied current pulse, comment otherwise
    %Iapp = pulsei*heavyside(t-ton)*heavyside(toff-t)*ones(n,1);
    
    %Use Eulers method to integrate eq.
    v = v + deltat*(0.04*v.^2 + 5*v + 140 - u + Iapp(:,i) + gsyn*W*s);
    u = u + deltat*(a*(b*v - u));
    %set v_tot,u_tot at this time point to the current value of v, u
    %v_tot(i,:)=v';
    %u_tot(i,:)=u';
    %check if any v has exceeded spike threshold. 
    fired=find(v>=vthresh);
    if ~isempty(fired)
        % reset cells that spiked
        v(fired)=c;
        u(fired)=u(fired)+d;
        % cut off spike peak to vpeak
        %v_tot(i,fired)=vpeak;
        % save spiketimes: [time of spike, cell that spiked]
        
        if isempty(spiketimes)
            spiketimes=horzcat(t*ones(length(fired),1), fired);
        else
            spiketimes=[spiketimes; t*ones(length(fired),1), fired];
        end
    end
    if ~isempty(spiketimes)
        % compute synaptic output for each cell
        for j=1:n
            cellout=spiketimes(spiketimes(:,2)==j,1);
            cellout=sum(exp(-(t-cellout)/taus));
            s(j)=cellout;
            %s_tot(i,:)=s';
        end
    end

    progress = i / totalpts;
    waitbar(progress, hbar, sprintf('Progress: %.0f%%', progress * 100));
end

close(hbar);


% % Plot raster plot
% figure(2)
% scatter(spiketimes(:,1),spiketimes(:,2),15)
% plot(spiketimes(:,1)/deltat,spiketimes(:,2),'o','MarkerFaceColor','b','MarkerSize',5)

% hold on; % Enable hold on to overlay plots
% oddNeurons = mod(spiketimes(:,2), 2) == 1; % Check for odd neuron IDs
% evenNeurons = ~oddNeurons; % Neurons with even IDs
% plot(spiketimes(oddNeurons, 1)/deltat, spiketimes(oddNeurons, 2), 'o', 'MarkerFaceColor', 'b', 'MarkerSize', 5);
% plot(spiketimes(evenNeurons, 1)/deltat, spiketimes(evenNeurons, 2), 'o', 'MarkerFaceColor', 'r', 'MarkerSize', 5);

% xlim([0,total_T])
% ylim([0,n+1])

clearvars -except Iapp spiketimes n W gsyn taus;

% heaviside function for current pulse
function hside=heavyside(x)
    if x >= 0
        hside = 1;
    else
        hside = 0;
    end
end
end