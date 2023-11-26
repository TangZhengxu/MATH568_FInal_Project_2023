close all;
clear;

load("data/KC_data.mat");
run('params.m');

taus = 50;
gsyn = 0;
conn_range = 1;

[W] = DecayingConnectivityMatrix(KC_d, conn_range);

[spiketimes]=LIF2D_simple_network(KC_d,W,gsyn,taus,KC_data);
 
plot_firing(KC_d, spiketimes);