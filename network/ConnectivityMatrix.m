function [W]=ConnectivityMatrix(KC_d)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set up connectivity matrix W

% 1D ring network
% set network size n

% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % 2-D grid with 4-neighbors
% % Define the dimensions of the grid
% rows = KC_d(1);
% cols = KC_d(2);
% 
% W = zeros(rows*cols, rows*cols);
% 
% for i = 1:rows
%     for j = 1:cols
%         % Calculate the index of the current item
%         current_item = (i - 1) * cols + j;
%         
%         % Define indices of neighboring items
%         left = (i - 1) * cols + j - 1;
%         right = (i - 1) * cols + j + 1;
%         top = (i - 2) * cols + j;
%         bottom = i * cols + j;
%         
%         % Check and update adjacency matrix
%         if j > 1
%             W(current_item, left) = 1; % Left neighbor
%         end
%         if j < cols
%             W(current_item, right) = 1; % Right neighbor
%         end
%         if i > 1
%             W(current_item, top) = 1; % Top neighbor
%         end
%         if i < rows
%             W(current_item, bottom) = 1; % Bottom neighbor
%         end
%     end
% end
% 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 2-D grid with 9-neighbors
% Define the dimensions of the grid
rows = KC_d(1);
cols = KC_d(2);

W = zeros(rows*cols, rows*cols);

for i = 1:rows
    for j = 1:cols
        % Calculate the index of the current item
        current_item = (i - 1) * cols + j;

        current_item = [i j];
        
        % Define indices of neighboring items
        left = [max(i-1,1) j];
        right = [min(i+1,cols) j];
        top = [i max(j-1,1)];
        bottom = [i min(j+1,rows)];

%         left = current_item - 1;
%         right = current_item + 1;
%         top = (i - 2) * cols + j;
%         bottom = i * cols + j;

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

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear crad allconnects noconnect checki i j

figure(1)
imshow(W, 'InitialMagnification', 'fit');
title('Connectivity Matrix (W)');
% % % % % %

end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%