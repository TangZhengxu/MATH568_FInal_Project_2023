%! before running this code, please add all subfolders into path
close all;
clear;

load("data/KC_data.mat");
PN_N = 6;
KC_d = [45,45];
KC_input = 2;
total_T = 2500;
deltat = 0.5;

taus = 50;
gsyn = 0;
conn_range = 1;

[W] = DecayingConnectivityMatrix(KC_d, conn_range);

[spiketimes]=LIF2D_simple_network(KC_d,W,gsyn,taus,KC_data);
 
plot_firing(KC_d, spiketimes);