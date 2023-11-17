function [W]=ConnectivityMatrix(KC_d)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Set up connectivity matrix W

% 1D ring network
% set network size n

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % 2-D grid
% Define the dimensions of the grid
rows = KC_d(1);
cols = KC_d(2);

% Initialize the adjacency matrix W
W = zeros(rows*cols, rows*cols);

% Iterate through each item in the grid
for i = 1:rows
    for j = 1:cols
        % Calculate the index of the current item
        current_item = (i - 1) * cols + j;
        
        % Define indices of neighboring items
        left = (i - 1) * cols + j - 1;
        right = (i - 1) * cols + j + 1;
        top = (i - 2) * cols + j;
        bottom = i * cols + j;
        
        % Check and update adjacency matrix
        if j > 1
            W(current_item, left) = 1; % Left neighbor
        end
        if j < cols
            W(current_item, right) = 1; % Right neighbor
        end
        if i > 1
            W(current_item, top) = 1; % Top neighbor
        end
        if i < rows
            W(current_item, bottom) = 1; % Bottom neighbor
        end
    end
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % nearest neighbor coupling
% % set radius of connectivity crad, # of outgoing synapses per neuron =
% % 2*crad

% crad = 1;
% 
% W = zeros(n);
% for k=1:crad
%     W = W +diag(ones(n-k,1),k)+diag(ones(n-k,1),-k);
% end
% 
% % add synapses to end cells = periodic boundary conditions
% for k=crad:-1:1
%     for j=crad:-1:k
%         W(n-(j-k),k) = 1;
%         W(k,n-(j-k)) = 1;
%     end
% end
% clear crad j k
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % % % all-to-all coupling
% W = ones(n);
% W = W - diag(ones(n,1));
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % random sparse connectivity with 2*crad outgoing synapses per neuron
% % start with all-to-all coupling and set n-2*crad synapses to zero
% crad=20;
% 
% W = ones(n);
% W = W - diag(ones(n,1));
% 
% %loop through rows of W
% for i=1:n
%     % randomly determine which synaptic connections to zero out
%     allconnects = randperm(n);
%     noconnect=allconnects(1:(n-1)-2*crad);
%     %Errorcheck so autapses are not included
%     checki=find(noconnect==i);
%     if ~isempty(checki)
%         noconnect(checki)=allconnects(n-2*crad+1);
%     end
%     % zero out synaptic connections
%     W(i,noconnect) = 0;
%     
% end
clear crad allconnects noconnect checki i j

% figure(1)
% imshow(W, 'InitialMagnification', 'fit');
% title('Connectivity Matrix (W)');
% % % % % %

end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%