function [ freemanDegree ] = degreeFreeman( adj )
%DEGREEFREEMAN returns with the centrality measure published by Freeman in
% 1979. The centrality sums the difference of the maximum degree and the
% actual node's degree and normalizes with the theoreticaly maximum value,
% which is (N-1)*(N-2), where N is the number of nodes. The input is an
% adjacency or sparse matrix, which is directed and could be both weighted
% or unweighted. 
% ##################
% Example:
% ##################
% Input: 
%
% adj=[1 1 0; 0 0 1; 0 0 0];        % could be sparse
% ##################
% Function Calling:
%
% freemanDegree=degreeFreeman(adj)
% ##################
% Outputs:
%
% freemanDegree =
%      1
% ##################
%  The algorithm was implemented by Daniel Leitold 

   % set diagonal to zero
   numNodes=numOfNodes(adj);
   
   if(numNodes>2)
       % generate degrees, and select the maximum
       degrees=degree(adj);
       degreeMax=max(degrees);

       % sum the differences
       summary=0;
       for idxI=1:numNodes
           summary=summary+(degreeMax-degrees(idxI));
       end

       freemanDegree=summary/((numNodes-1)*(numNodes-2));
   else
       freemanDegree=[];
   end
   
end

