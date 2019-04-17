function [nodes, sets] = setCover(adj, maxEnergy)
%SETCOVER generate the set of driver nodes for adjacency matrix, or the
% sensor nodes for state-transition matrix such that the relative degree of
% the designed system does not exceed maxEnergy. The structural
% controllability or observability is not granted by this method.
% Output: the driver (or sensor) nodes, and the set they can cover. 
% ##################
% Example:
% ##################
% Inputs: 
%
% adj = [0 1 0 0; 0 0 1 0; 1 0 0 1; 0 0 0 0];
% maxEnergy = 1;
% ##################
% Function Calling:
% 
% [nodes, sets] = setCover(adj, maxEnergy);
% ##################
% Output:
%
% nodes =
%      1
%      3
%  
% sets =
%      1     1
%      1     0
%      0     1
%      0     1
% ##################
%  The algorithm was implemented by Daniel Leitold 

% add diagonal
adj(1:length(adj)+1:end) = 1;

% create reachability matrix
reach = adj;
for idxI = 2:maxEnergy
    reach = reach | adj^idxI;
end

% get result
[sets, nodes] = greedyscp(logical(reach'), 1:length(reach));