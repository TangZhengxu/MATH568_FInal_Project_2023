clear
% load PN responses to odors
% there are 23 PNs simulated from real recording data
% the odor_PN_t dimensions are odor_index (1:110) PN_index (1:23) and time
% (1:2500), each step is 0.5 ms
load("odor_PN_t.mat")
% here we use odor#1 as a example
odor1_PN = squeeze(odor_PN_t(1,:,:));

%plot the response, odors stimuli are given from 500 ms to 1000 ms
figure(1)
plot((1:2500)/2,odor1_PN',"LineWidth",2)
xlabel("time ms")
ylabel("PN Responses(AU)")

% we assum A is the synaptic transmission scaler
A = 0.01;
% w is the connetivity from PN to KC
% at each time step, the input current to each KC is A*sum(w_i*PN_i)

% to build the connectiviy matrix, we need the PN_KC_connect funtion 
% we assume there are 45*45 = 2025 KCs forming a 2D KC matrix, each KC
% randomly receive 6 inputs from 23 PNs, the random selection is without
% replacement

% [PNKConnectivity] = PN_KC_connect(PN_N,KC_d,KC_input, random_mode,random_seed,validation)
% PN_N: number of PNs
% KC_d: KC matrix dimentions
% KC_input: number of inputs to each KC
% random_mode: "full random" randomly select | "local random" KC closed to
% each other have higher chance to receive similar inputs
% random_seed: control the randomness
% validation: plot the sapatial distribution, only for test the parameters


% for full random connection
w_matrix = PN_KC_connect(23,[45,45],6,"full random",1,false);

% for local random connection
% w_matrix_local = PN_KC_connect(23,[45,45],6,"local random",1,false);

% input to KC at position of (m,n)
% m = 5;
% n = 8;
KC_5_8_input = A*squeeze(w_matrix(5,8,:))'*odor1_PN;
% m = 18;
% n = 2;
KC_18_2_input = A*squeeze(w_matrix(18,2,:))'*odor1_PN;
% m = 40;
% n = 34;
KC_40_34_input = A*squeeze(w_matrix(40,34,:))'*odor1_PN;
figure(2)
hold on
plot((1:2500)/2,KC_5_8_input',"LineWidth",2)
plot((1:2500)/2,KC_18_2_input',"LineWidth",2)
plot((1:2500)/2,KC_40_34_input',"LineWidth",2)
xlabel("time ms")
ylabel("KC input current")
legend("KC_{5,8}","KC_{18,2}","KC_{40,34}")



