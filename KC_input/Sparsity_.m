
%Lifetime sparseness
[N, num_KCs] = size(KC_data); 

S_kc = zeros(1, num_KCs); 

for kc = 1:num_KCs
    r = KC_data(:, kc); 
    mean_r = mean(r);
    S_kc(kc) = (1 - (mean_r^2) / mean(r.^2)) / (1 - 1/N);
end


%Population sparceness
[num_KCs, num_odors] = size(KC_data); 

Sp = zeros(1, num_odors); 

for odor = 1:num_odors
    r = KC_data(:, odor); 

    mean_r = mean(r);
    mean_squared_r = mean(r .^ 2);

    Sp(odor) = (1 - (mean_r ^ 2) / mean_squared_r) / (1 - 1/num_KCs);
end

%Zero Response Rate not work yet
[N, num_KCs] = size(KC_data); 

zero_threshold = 0.01; 

zero_response_rates = zeros(N, 1);


for i = 1:N
    zero_responses = sum(KC_data(i, :) < zero_threshold); 
    zero_response_rates(i) = zero_responses / num_KCs; 
end

%Standard Information Entropy

[num_odors, num_KCs] = size(KC_data); 

H_KC = zeros(1, num_KCs);

for kc = 1:num_KCs

    kc_responses = KC_data(:, kc);


    unique_responses = unique(kc_responses); 
    probabilities = zeros(size(unique_responses));
    for i = 1:length(unique_responses)
        probabilities(i) = sum(kc_responses == unique_responses(i)) / num_odors;
    end


    H_KC(kc) = -sum(probabilities .* log(probabilities + eps)); 
end

%Difference Infromation Entropy

[num_odors, num_KCs] = size(KC_data);


H_KC = zeros(1, num_KCs);

for kc = 1:num_KCs

    kc_responses = KC_data(:, kc);

    [pdf, x] = ksdensity(kc_responses);

    H_KC(kc) = -trapz(x, pdf .* log(pdf + eps)); 
end


