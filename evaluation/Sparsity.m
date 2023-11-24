function [S_kc, F_kc, counts] = Sparsity(spiketimes, KC_d)
    % obtain spikes counts per KC
    KC_N = KC_d(1)*KC_d(2);
    % Extract the second column as IDs
    ids = spiketimes(:, 2);
    
    counts = zeros(1,KC_N);
    % Count occurrences of each unique integer
    for i = 1:KC_N
        counts(i) = sum(ids == i);
    end
    % sparsness, 1 is most sparse
    S_kc = (1-((sum(counts)/KC_N)^2/(sum(counts.^2)/KC_N)))/(1-1/KC_N);
    % responding fraction
    F_kc = sum(counts>0)/KC_N;



%     
% [N, num_KCs] = size(KC_data); 
% 
% S_kc = zeros(1, num_KCs); 
% 
% for kc = 1:num_KCs
%     r = KC_data(:, kc); 
%     mean_r = mean(r);
%     S_kc(kc) = (1 - (mean_r^2) / mean(r.^2)) / (1 - 1/N);
% end
% 
% 
