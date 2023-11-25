close all;
clear;

load("data/KC_data.mat");
run('params.m');

taus = 50;
gsyn = 0;

[W] = DecayingConnectivityMatrix(KC_d);

% [spiketimes]=LIF2D_simple_network(KC_d,W,gsyn,taus,KC_data);
%  
% plot_firing(KC_d, spiketimes);