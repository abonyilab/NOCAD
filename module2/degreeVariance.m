function [ varianceDegree ] = degreeVariance( adj )
%DEGREEVARIANCE returns with the degree variance centrality measure. The
% centrality sums the square difference of the average degree and the 
% actual node's degree and divides with the number of nodes. The input is 
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
% varianceDegree=degreeVariance(adj)
% ##################
% Outputs:
%
% varianceDegree =
%      0.2222
% ##################
%  The algorithm was implemented by Daniel Leitold 

   % generate degrees, and calculate the mean
   numOfNodes=numNodes(adj);
   if(numOfNodes~=0)
       degrees=degree(adj);
       degreeMean=mean(degrees);

       % create the sum
       summary=0;
       for idxI=1:numOfNodes
           summary=summary+(degrees(idxI)-degreeMean)^2;
       end

       varianceDegree=summary/numOfNodes;
   else
       varianceDegree=0;
   end
   
end

