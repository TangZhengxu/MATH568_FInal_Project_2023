close all;
clear;

load("../data/KC_data.mat");
run('../params.m');

taus = 5;
gsyn = -5;

[W] = ConnectivityMatrix(KC_d);

% LIF2D_simple_network;
[spiketimes]=LIF2D_simple_network(KC_d,W,gsyn,taus,KC_data);
% % [traces,traces_all] = spiketraces(n,spiketimes);

plot_firing(KC_d, spiketimes);