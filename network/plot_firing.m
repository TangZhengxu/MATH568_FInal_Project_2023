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

[sck, f_kc, ~] = Sparsity(spiketimes,KC_d); % sparseness
fprintf('Sparseness: %.3f\n', sck);
fprintf('Responding fraction: %.1f%%\n', f_kc * 100);

figure;
imagesc(counts);
colormap(pink);
clim([0, max(counts(:))]);
colorbar;
xlabel('KC neuron x');
ylabel('KC neuron y');
title(sprintf('Total firing (Sp: %.3f)', sck))

% figure;
% bar(1:n, counts(:));
% xlabel('KC neuron');
% ylabel('Total firing');
% title('Total firing');

end
