function [ scottDegree ] = degreeScott( adj )
%DEGREESCOTT returns with the directed version of centrality measure 
% published by Scott in 2000. The centrality normalizes the degree in the
% network. It does not take into the loop in the centrality. The input is
% an adjacency or sparse matrix, which is directed and could be both 
% weighted or unweighted. 
% ##################
% Example:
% ##################
% Input: 
%
% adj=[1 1 0; 0 0 1; 0 0 0];        % could be sparse
% ##################
% Function Calling:
%
% scottDegree=degreeScott(adj)
% ##################
% Outputs:
%
% scottDegree =
%      0.2500    0.5000    0.2500
% ##################
%  The algorithm was implemented by Daniel Leitold 

   numNodes=numOfNodes(adj);
   if(numNodes>1)
       scottDegree=degree(adj)./(2*(numNodes-1));
   else
       scottDegree=zeros(1,numNodes);
   end
   
end

