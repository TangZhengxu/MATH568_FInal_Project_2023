function plot_firing(KC_d, spiketimes)
n = KC_d(1)*KC_d(2);
% Extract the second column as IDs
ids = spiketimes(:, 2);

counts = zeros(1,n);
% Count occurrences of each unique integer
for i = 1:n
    counts(i) = sum(ids == i);
end
counts = reshape(counts, KC_d(1), KC_d(2));

figure;
imagesc(counts);
colormap(gray);
clim([0, max(counts(:))]);
colorbar;
xlabel('KC neuron x');
ylabel('KC neuron y');
title('Total firing');

figure;
bar(1:n, counts(:));
xlabel('KC neuron');
ylabel('Total firing');
title('Total firing');
end
