function newNodes = analyseComponents ( A, actualNodes, maxEnergy)
%ANALYSECOMPONENTS function analyses components and decrease their degree
% to ensure the required maxEnergy. If A is adjacency, not state transition
% matrix, then actualNodes are driver nodes that will be expanded in the
% resulted newNodes. The expansion based on the centrality measures. If A
% is the state transition matrix, then actualNodes are sensors.
% The components created as: for each node in actualNodes, the closest set
% of nodes are generated, i.e. each node belongs to the closest driver or
% sensor nodes. 
% The function uses the matlab BGL toolbox. 
% ##################
% Example:
% ##################
% Input: 
%
% A = [0 1 0 0; 0 0 1 0; 1 0 0 1; 0 0 0 0];
% actualNodes = 1;
% maxEnergy = 1;
% ##################
% Function Calling:
%
% newNodes = analyseComponents( A, actualNodes, maxEnergy)
% ##################
% Outputs:
% 
% newNodes =
%      2
%      3
% ##################
%  The algorithm was implemented by Daniel Leitold 

% Add matlab_bgl to the path

if ~exist('all_shortest_paths', 'file')
   mfilepath=fileparts(which('analyseComponents'));
   addpath([mfilepath,'\..\matlab_bgl']);
end
   
% Find geodesic paths to determine relative degree
if issparse(A) 
  paths=all_shortest_paths(A);
else
  paths=all_shortest_paths(sparse(A));
end
% Geodesic paths from actualNodes that is equal with energy
paths = paths(actualNodes,:);
[energy, byNode] = min(paths,[],1);
newNodes = [];
for actNode=unique(byNode)
    idx = find(byNode == actNode);
    % If the energy of one component is higher than limit
    if max(energy(idx))>maxEnergy 
        % Create the component, then determine a new node
        newA = A(idx,idx);
        % Generate closeness and betweenness centralities
        [betweenness, closeness] = measures(newA);
        % New node index of the driver/sensor that is analysed
        actIdOfActNode = find(idx==actualNodes(actNode));
        % Exclude the driver/sensor
        betweenness(actIdOfActNode) = -1*(betweenness(actIdOfActNode)+1);
        % Determine the new driver/sensor
        [~, newId] = max(betweenness.*closeness);
        % Recursive function: determine, maxEnergy is ensured
        newNodesIds = analyseComponents(newA, [actIdOfActNode, newId], maxEnergy);
        newNodes = union(newNodes, idx(newNodesIds));
    else
        % If the component ensures maxEnergy
        newNodes = union(newNodes, actualNodes(actNode));
    end
    
    % newNodes contains all from actualNodes.
end