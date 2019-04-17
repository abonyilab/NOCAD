function [nodes, sets] = setCoverExcept(adj, maxEnergy, selected)
%SETCOVEREXCEPT generate the set of driver nodes for adjacency matrix, or 
% the sensor nodes for state-transition matrix such that the relative 
% degree of the designed system does not exceed maxEnergy. The method
% extend the set of drivers (or sensors) in vector selected. If the drivers
% (or sensors) grant structural controllability (or observability) the the
% resulted design is still controllable (or observable) and ensure that the
% relative degree is smaller than maxEnergy.
% Output: the driver (or sensor) nodes, and the set they can cover. 
% ##################
% Example:
% ##################
% Inputs: 
%
% adj = [0 1 0 0; 0 0 1 0; 1 0 0 1; 0 0 0 0];
% maxEnergy = 1;
% selected = [4];
% ##################
% Function Calling:
% 
% [nodes, sets] = setCoverExcept(adj, maxEnergy, selected);
% ##################
% Output:
%
% 
% nodes =
%      1
%      2
%      4
% 
% sets =
%      1     0     0
%      1     1     0
%      0     1     0
%      0     0     1
% ##################
%  The algorithm was implemented by Daniel Leitold 

% add diagonal
adj(1:length(adj)+1:end) = 1;

% create reachability matrix
reach = adj;
for idxI = 2:maxEnergy
    reach = reach | adj^idxI;
end

% get covered
reachtmp = reach;
idxCol = find(sum(reach(selected,:),1) ~= 0);
reachtmp(:,idxCol) = [];
idxRow = find(sum(reachtmp,2)~=0);
reachtmp = reachtmp(idxRow,:);

% get result
[sets, nodes] = greedyscp(logical(reachtmp'), idxRow);
nodes = union(nodes, selected);
sets = reach(nodes,:);