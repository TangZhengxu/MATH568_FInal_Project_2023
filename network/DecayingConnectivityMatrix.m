function [W]=DecayingConnectivityMatrix(KC_d,conn_range)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2-D grid with neighbor connectivity decaying with distance

% connectivity range; higher the value, 
% slower the decay of connectivity strength with distance
% conn_range = 2.5; set this as parameter

n = KC_d(1)*KC_d(2);
rows = KC_d(1);
cols = KC_d(2);

W = zeros(n, n);

for i = 1:rows
    for j = 1:cols
        % Calculate the index of the current item
        current_item = [i j];

        [conn] = Gaussian2d(KC_d, conn_range, current_item);
        curr = (current_item(1) - 1) * cols + current_item(2);
        W(curr, :) = conn(:);
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear crad allconnects noconnect checki i j
% 
% figure(1)
% % imshow(W, 'InitialMagnification', 'fit');
% imagesc(W);
% % clim([0, max(W(:))]);
% colormap(gray);
% % colorbar;
% xlabel('KC index');
% ylabel('KC index');
% title('Connectivity Matrix');
% % % % % %

% i_x = ceil(KC_d(1)/2); i_y = ceil(KC_d(2)/2);
% i = (i_x-1)*KC_d(2) + i_y; % choosing a middle index to visualize better
% W_i = reshape(W(i, :), KC_d(1), KC_d(2));
% figure;
% imagesc(W_i);
% colormap(pink);
% colorbar;

end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%