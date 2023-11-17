close all;
clear;

load("../data/KC_data.mat");
run('../params.m');

n = KC_d(1)*KC_d(2);

taus = 5;
gsyn = -1;

[W] = ConnectivityMatrix(KC_d);

% LIF2D_simple_network;
[spiketimes]=LIF2D_simple_network(n,W,gsyn,taus,KC_data);
% % [traces,traces_all] = spiketraces(n,spiketimes);
% 
% Extract the second column as IDs
ids = spiketimes(:, 2);

% Calculate the count of each ID
[counts, ~, ~] = histcounts(ids, n);

uniqueIds = 1:n;

% Create a matrix with IDs and their corresponding counts
resultMatrix = [uniqueIds', counts'];

% Sort the result based on IDs
sortedResult = sortrows(resultMatrix, 1);

% Extract keys and values
keys = sortedResult(:, 1);
values = sortedResult(:, 2);

figure(3)
% Create a bar chart
bar(keys, values);