function [ dens ] = density( adj )
%DENSITY returns with the density of the network described with adj, so
% the proportion of the existing edges and the all possible edges. adj is
% an adjacency or sparse matrix, which is directed, and could be both
% weighted or unweighted. This function counts the loops, so the density
% reach 1 if every node connects to all others, and has a loop.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[1 1; 0 0];           % could be sparse
% ##################
% Function Calling:
%
% dens=density(adj)
% ##################
% Output:
%
% dens =
%      0.5000
% ##################
%  The algorithm was implemented by Daniel Leitold 

   numOfNodes=numNodes(adj);
   if(numOfNodes~=0)
       dens=numEdges(adj)/(numOfNodes^2);
   else
       dens=0;
   end
   
end

