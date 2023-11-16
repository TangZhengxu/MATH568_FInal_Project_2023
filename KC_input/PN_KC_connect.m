function [PNKConnectivity] = PN_KC_connect(PN_N,KC_d,KC_input, random_mode,random_seed,validation)
% PN_N: number of PNs
% KC_d: KC matrix dimentions
% KC_input: number of inputs to each KC
% random_mode: "full random" randomly select | "local random" KC closed to
% each other have higher chance to receive similar inputs
% random_seed: control the randomness
% validation: plot the sapatial distribution, only for test the parameters

% PN_KC_connect(23,[45,45],"full random",1,true)

rng(random_seed); % set random seed

if (random_mode == "full random")
    weight_matrix = ones([KC_d PN_N])/PN_N; % randomly select each PN with even weights
elseif (random_mode == "local random")
    PN_KC_calyx_affinity = calyx(KC_d,11,4,PN_N);
    weight_matrix = normalize(PN_KC_calyx_affinity,3,"norm",1);
end
PNKConnectivity = zeros([KC_d PN_N]);
for n = 1:KC_d(1)
    for m=1:KC_d(2)
       PNKConnectivity(n,m,:) = rand_connect(weight_matrix(n,m,:),KC_input); % each KC randomly receive 6 inputs from PNs
    end
end

if validation
    corr_matrix_w = zeros(KC_d);
    corr_matrix_KC = zeros(KC_d);
    repeat_matrix_KC = zeros(KC_d);
    for n = 1:KC_d(1)
        for m=1:KC_d(2)
            weight_corr = corrcoef(weight_matrix(1,1,:),weight_matrix(n,m,:));
            corr_matrix_w(n,m) = weight_corr(1,2);
            KC_corr = corrcoef(PNKConnectivity(1,1,:),PNKConnectivity(n,m,:));
            corr_matrix_KC(n,m) = KC_corr(1,2);
            repeat_matrix_KC(n,m) = max(PNKConnectivity(n,m,:));
        end
    end

figure(1)
heatmap(corr_matrix_w)
colormap(cool)
title("Correlation of randomly selecting weights")
xlabel("KC index")
ylabel("KC index")



figure(2)
heatmap(corr_matrix_KC)
colormap(cool)
title("Correlation of KC connectivity")
xlabel("KC index")
ylabel("KC index")

figure(3)
histogram(repeat_matrix_KC)
title("Histogram of repeated PN-KC connections")
xlabel("repeated PN-KC connection #")
ylabel("KC counts")
end
end



%%%% helper funtions, not fully documented %%%

function [KC_connectivity] = rand_connect(weight, KC_input)
    pn_n = length(weight);
    KC_connectivity = zeros(pn_n,1);
    PN_index = randsample(1:pn_n,KC_input,true,weight);
    for PN_i = 1:KC_input
        KC_connectivity(PN_index(PN_i)) = KC_connectivity(PN_index(PN_i)) + 1;
    end
end


    

function [PN_connecting_matrix] = calyx(KC_d,sigma,N,PN_N)
    Calyx_affinity = zeros([KC_d PN_N]);
    for pn = 1:PN_N
        Calyx_affinity(:,:,pn) = bouton(KC_d,sigma,N);
    end
    PN_connecting_matrix = Calyx_affinity;
end
        




function [PN_conneting_prob] = bouton(KC_d,sigma,N)
% this construct connecting probability martix on a 2D space based on the
% mushroom body calyx. For each subtype of PN, I set some 2D connecting
% hot_spot in the 2D sapce to assign a value for connection probability

    bouton_layer = zeros(KC_d);

    X = 1:KC_d(1);
    Y = 1:KC_d(2);
    Y = Y';
    for i = 1:N
        center_x = randsample(KC_d(1),1);
        center_y = randsample(KC_d(2),1);
        bouton_layer = exp(-1/(sigma^2)*((Y-center_y).^2 + (X-center_x).^2)) + bouton_layer;
    end
    PN_conneting_prob = bouton_layer;
end
