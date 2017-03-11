function [ pageR ] = pageRank( adj )
%PAGERANK returns with the PageRank of the network described with adj. adj
% is an adjacency matrix, which could be both weighted or unweighted. 
% The alpha parameter is 0.85, as it is in Google's case.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[1 1; 0 0];       % could be sparse
% ##################
% Function Calling:
%
% pageR=pageRank(adj)
% ##################
% Output:
%
% pageR =
%     50    50
% ##################
%  The algorithm was implemented by Daniel Leitold 

   % the alpha parameter gives the probabilty that the user surfs over
   % links, and not jump on another site. 
   alpha=0.85;
   beta=1;
    
   % calculate PageRank
   numOfNodes=numNodes(adj);	
   adj(adj~=0)=1;
   outDegree=degreeOut(adj);
   outDegree(outDegree<1)=1;
   D=diag(outDegree);
   pageR=beta*(D*((D-alpha*adj')\ones(numOfNodes,1)));
    
   % percent conversion
   if(~isempty(pageR))
      pageR=100*(pageR/sum(pageR))';
   end

end

