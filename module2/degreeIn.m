function [ inDegree ] = degreeIn( adj )
%DEGREEIN returns with the in-degree centrality of the network described 
% with adj, so the number of neighbors which have edge to the node. 
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
% inDegree=degreeIn(adj)
% ##################
% Output:
%
% inDegree =
%      0     1
% ##################
%  The algorithm was implemented by Daniel Leitold 

   numOfNodes=numNodes(adj);
   % change weights
   adj(adj~=0)=1;
   % remove loops
   adj(1:numOfNodes+1:end)=0;
   inDegree=sum(adj,1);

end

