function [ numOfEdges ] = numEdges( adj )
%NUMEDGES returns with the number of the edges in the network described
% with adj. adj is an adjacency or sparse matrix, which is directed and
% could be both weighted or unweighted.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[1 1; 0 0];
% ##################
% Function Calling:
%
% numOfEdges=numEdges(adj)
% ##################
% Output:
%
% numOfEdges =
%      2
% ##################
%  The algorithm was implemented by Daniel Leitold 

   numOfEdges=nnz(adj);

end

