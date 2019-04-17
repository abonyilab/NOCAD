function [ diam ] = diameter( adj )
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
% diam=diameter(adj)
% ##################
% Output:
%
% diam =
%      1
% ##################
%  The algorithm was implemented by Daniel Leitold 

   % the function uses the matlab_bgl to generate the shortest paths
   if ~exist('all_shortest_paths', 'file')
      mfilepath=fileparts(which('diameter'));
      addpath([mfilepath,'\..\matlab_bgl']);
   end

   % determine the length of paths, and change the Inf valuest to zero
   dist=all_shortest_paths(sparse(adj));  
   dist(dist==Inf)=0;
   diam=max(dist(:));

end

