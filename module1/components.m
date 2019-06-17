function [ ci, sizes ] = components( adj )
%COMPONENTS Compute the strongly connected components of a directed graph.
% The input is a sparse adjacency matrix of the graph, and the output ci is
% the vector contains the component indices an sizes is a vector that
% contains the sizes of each components.
% ##################
% Example:
% ##################
% Input: 
%
% adj=sparse([1 2 3 3], [2 3 1 4], 1, 4, 4);   % must be sparse
% ##################
% Function Calling:
%
% [ci sizes] = components(adj)
% ##################
% Outputs:
%
% ci =
%      2
%      2
%      2
%      1
% 
% sizes =
%      1
%      3
% ##################
%  The algorithm was implemented by Daniel Leitold 

% add octave networks toolbox to find components
if ~exist('adj2adjL', 'file')
  mfilepath=fileparts(which('components'));
  addpath([mfilepath,'\..\octave-networks-toolbox']);
end

ci = adjL2edgeL(tarjan(adj2adjL(adj)));
ci = sortrows(ci, 2);
ci = ci(:,1);
sizes = hist(ci, unique(ci))';
end

