function [ shortestPaths ] = allShortestPaths( adj )
%ALLSHORTESTPATHS calculates the weighted geodesic paths between all node 
% pairs. The input matrix adj, describes the adjacency matrix of the
% graph. The output shortestPaths contains a matrix that presenet in row i
% and colum j the shortest path from node i to node j. The method uses the
% simpleDijkstra function from the octave-networks-toolbox.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[0 1 0 0; 0 0 1 0; 1 0 0 1; 0 0 0 0];       % could be sparse
% ##################
% Function Calling:
%
% shortestPaths=allShortestPaths(adj)
% ##################
% Output:
%
% shortestPaths =
%      0     1     2     3
%      2     0     1     2
%      1     2     0     1
%    Inf   Inf   Inf     0
% ##################
%  The algorithm was implemented by Daniel Leitold.

% add octave networks toolbox to find components
if ~exist('simpleDijkstra', 'file')
  mfilepath=fileparts(which('simpleDijkstra'));
  addpath([mfilepath,'\..\octave-networks-toolbox']);
end

shortestPaths = [];
numOfNodes = length(adj);
for idxI = 1:numOfNodes
    shortestPaths = cat(1, shortestPaths, simpleDijkstra(adj, idxI));
end
end
