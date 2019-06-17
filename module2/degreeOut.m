function [ outDegree ] = degreeOut( adj )
%DEGREEOUT returns with the out-degree centrality of the network described 
% with adj, so the number of neighbors which have edge from the node. 
% adj is an adjacency or sparse matrix, which is directed,and could be both
% weighted or unweighted. This function removes the loops, so it does not
% count them.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[1 1; 0 0];           % could be sparse
% ##################
% Function Calling:
%
% outDegree=degreeOut(adj)
% ##################
% Output:
%
% outDegree =
%      1     0
% ##################
%  The algorithm was implemented by Daniel Leitold 

   numNodes=numOfNodes(adj);
   % change weights
   adj(adj~=0)=1;
   % remove loops
   adj(1:numNodes+1:end)=0;
   outDegree=sum(adj,2)';

end

