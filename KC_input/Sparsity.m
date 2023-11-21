
[N, num_KCs] = size(KC_data); 

S_kc = zeros(1, num_KCs); 

for kc = 1:num_KCs
    r = KC_data(:, kc); 
    mean_r = mean(r);
    S_kc(kc) = (1 - (mean_r^2) / mean(r.^2)) / (1 - 1/N);
end


