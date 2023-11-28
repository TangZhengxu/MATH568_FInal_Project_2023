%! before running this code, please add all subfolders into path
clear

load('simulation_results/part_simulation_seed1/simulation_seed1.mat');

% default parameters

odor_N = 110;
PN_N = 23; 
KC_d = [45,45];
KC_input_N = 6;
total_T = 2500;
deltat = 0.5;
A = 0.005; 
taus = 50;
KC_n = KC_d(1)*KC_d(2);

exp_i = 1;

odor_list = [1]; % 1:3; % update this to experiment with different odor lists

odor_N_ = length(odor_list);

KC_all = zeros(odor_N_, KC_n);

for odor_i = 1:odor_N_
    KC_all(odor_i, :) = experiment(exp_i).KC_response(odor_list(odor_i), :);
end

% visualization of KC inputs
for odor_i = 1:odor_N_
    KC_input_curr = experiment(exp_i).KC_input(odor_list(odor_i), :);
    figure(odor_i)
    imagesc(reshape(KC_input_curr, KC_d(1), KC_d(2)));
    colormap(bone);
    colorbar;
    title(sprintf('KC input current from odor %d', odor_list(odor_i)));
end

% visualization of KC outputs
for odor_i = 1:odor_N_
    KC_f = KC_all(odor_i, :);
    figure(10+odor_i)
    imagesc(reshape(KC_f, KC_d(1), KC_d(2)));
    colormap(pink);
    colorbar;
    title(sprintf('KC firing from odor %d', odor_list(odor_i)));
end