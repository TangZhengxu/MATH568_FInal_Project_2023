KC_d = [45,45];
KC_n = KC_d(1)*KC_d(2);

exp_i = 2;

odor_list = 1:110; % update this to experiment with different odor lists
noisy_i = 4; % update this to specify which odor to add noise to

odor_N_ = length(odor_list);

KC_all = zeros(odor_N_, KC_n);

for odor_i = 1:odor_N_
    KC_all(odor_i, :) = experiment(exp_i).KC_response(odor_list(odor_i), :);
end

gaussian_noise = 3*randn(1, KC_n);
KC_noisy = KC_all(noisy_i, :) + gaussian_noise;
KC_noisy(KC_noisy<0) = 0;
KC_noisy = round(KC_noisy);

dis = zeros(odor_N_, 1);
for odor_i = 1:odor_N_
    dis(odor_i) = pdist2(KC_all(odor_i, :), KC_noisy, 'euclidean');
end
sim = -dis; % similarity
pred = exp(sim) / sum(exp(sim));

figure(10)
bar(odor_list, pred)
% ylim([0, 1])
title(sprintf('Prediction probability when odor is similar to [%d]', odor_list(noisy_i)))
% 
% % visualization of KC outputs
% for odor_i = 1:odor_N_
%     figure(odor_i)
%     imagesc(reshape(KC_all(odor_i, :), KC_d(1), KC_d(2)));
%     colormap(pink);
%     colorbar;
%     title(sprintf('KC output from odor %d', odor_list(odor_i)));
% end
% 
% figure(odor_N_+1)
% imagesc(reshape(KC_noisy, KC_d(1), KC_d(2)));
% colormap(pink);
% colorbar;
% title(sprintf('KC output with noise added in [%d]', odor_list(noisy_i)))
