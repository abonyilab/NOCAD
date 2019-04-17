function [ numOfNodes ] = numNodes( adj )
%NUMNODES returns with the number of the nodes in the network described
% with adj. adj is an adjacency or sparse matrix, which could be both 
% directed and undirected, and both weighted or unweighted.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[1 1; 0 0];       % could be sparse
% ##################
% Function Calling:
%
% numOfNodes=numNodes(adj)
% ##################
% Output:
%
% numOfNodes =
%      2
% ##################
%  The algorithm was implemented by Daniel Leitold 

   numOfNodes=length(adj);

end

