function [ diameter ] = diam( adj )
%DIAMETER returns with the diameter of the network described with adj. adj
% is an adjacency or sparse matrix, which is directed and could be both
% weighted or unweighted. The returned value the biggest not Inf value
% of the paths, so it can used on directed graph as well.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[1 1; 0 0];       % could be sparse
% ##################
% Function Calling:
%
% diameter=diam(adj)
% ##################
% Output:
%
% diameter =
%      1
% ##################
%  The algorithm was implemented by Daniel Leitold 

   % determine the length of paths, and change the Inf valuest to zero
   dist=allShortestPaths(adj);
   dist(dist==Inf)=0;
   diameter=max(dist(:));

end

