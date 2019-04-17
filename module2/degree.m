function [ degrees ] = degree( adj )
%DEGREE returns with the degree centrality of the network described 
% with adj, so the number of neighbors which have edge to or from the node. 
% adj is an adjacency matrix, which is directed,and could be both weighted 
% or unweighted. This function removes the loops.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[1 1; 0 0];           % could be sparse
% ##################
% Function Calling:
%
% degrees=degree(adj)
% ##################
% Output:
%
% degrees =
%      1     1
% ##################
%  The algorithm was implemented by Daniel Leitold 

   degrees=degreeIn(adj)+degreeOut(adj);
   
end

