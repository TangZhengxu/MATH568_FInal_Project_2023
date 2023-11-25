function [W]=ConnectivityMatrix(KC_d)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set up connectivity matrix W

% 1D ring network
% set network size n

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % 2-D grid with 9-neighbors
% % Define the dimensions of the grid
rows = KC_d(1);
cols = KC_d(2);

W = zeros(rows*cols, rows*cols);

for i = 1:rows
    for j = 1:cols
        % Calculate the index of the current item
        current_item = [i j];
        
        % Define indices of neighboring items
        left = [max(i-1,1) j];
        right = [min(i+1,cols) j];
        top = [i max(j-1,1)];
        bottom = [i min(j+1,rows)];

        top_left = [left(1) top(2)];
        top_right = [right(1) top(2)];
        bottom_left = [left(1) bottom(2)];
        bottom_right = [right(1) bottom(2)];

        neighbors = [current_item; left; right; top; bottom; top_left; top_right; bottom_left; bottom_right];
        
        for neigh = neighbors'
            curr = (current_item(1) - 1) * cols + current_item(2);
            ng = (neigh(1) - 1) * cols + neigh(2);
            W(curr, ng) = 1;
        end
    end
end
% 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear crad allconnects noconnect checki i j

figure(1)
% imshow(W, 'InitialMagnification', 'fit');
imagesc(W);
% clim([0, max(W(:))]);
colormap(gray);
% colorbar;
xlabel('KC index');
ylabel('KC index');
title('Connectivity Matrix');
% % % % % %

end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%