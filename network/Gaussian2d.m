function [gaussian_filter]=Gaussian2d(filter_size, sigma, center)
% filter_size = [7 9]; % Define the size of the filter
% sigma = 1.5; % Adjust sigma to control the spread of the Gaussian
% center = [3, 6];

% Define the center coordinates
center_x = center(1);
center_y = center(2);

% Create a meshgrid for the filter centered at (center_x, center_y)
[x, y] = meshgrid(1:filter_size(1), 1:filter_size(2));
x = x - center_x;
y = y - center_y;

% Create a Gaussian filter
gaussian_filter = exp(-(x.^2 + y.^2) / (2*sigma^2));

% Ensure the maximum value is at the center
gaussian_filter = gaussian_filter / max(gaussian_filter(:));

% threshold to remove small values to ease further computation
gaussian_filter(gaussian_filter<0.01) = 0;

% figure(1);
% subplot(2, 2, 2);
% imagesc(gaussian_filter);
% colormap(gray);
% title('Gaussian Filter');
% 
% subplot(2, 2, 1);
% plot(gaussian_filter(:, center_x), 1:filter_size(2));
% ylim(gca, [1, filter_size(2)]);
% set(gca, 'YDir', 'reverse');
% title(['Vertical Slice at x = ', num2str(center_x)]);
% 
% subplot(2, 2, 4);
% plot(gaussian_filter(center_y, :));
% xlim(gca, [1, filter_size(1)]);
% title(['Horizontal Slice at y = ', num2str(center_y)]);

% figure(1);
% plot(-22:22, gaussian_filter(center_y, :));
% xlim(gca, [0, 22]);
% title('Decay of connectivity weight with distance');
% xlabel("r")
% ylabel("w_{syn}")

end