function [ OC ] = observeCentrality( Amatrix, Cmatrix )
%OBSERVECENTRALITY calculates the centrality measures from the A and C
% matrices. The output is a N length vector, where the i. element is the
% centrality value of the state i. The non-sensor nodes' centrality value
% are zero.
% ##################
% Example:
% ##################
% Inputs: 
%
% Amatrix=[1 0; 1 0];       % could be sparse
% Cmatrix=[0 1];            % could be sparse
% ##################
% Function Calling:
% 
% [OC]=observeCentrality(Amatrix, Cmatrix)
% ##################
% Output:
%
% OC =
%      0     2
% ##################
%  The algorithm was implemented by Daniel Leitold 


    numOfNodes=numNodes(Amatrix);
    OC=zeros(1,numOfNodes);
    sensorNodes=find(sum(Cmatrix,1)~=0);

    % Iterate over sensor nodes
    for actualNode=sensorNodes
        % Generate the c vector for i. sensor node
        subCmatrix=sparse([],[],1,1, numOfNodes);
        subCmatrix(actualNode)=1;
        
        % calculate modified observability matrix: [c; cA; ..; cA^(N-1)]
        observeMatrix=subCmatrix;
        for idxI=1:numOfNodes-1
            subCmatrix=subCmatrix*Amatrix;
            observeMatrix=[observeMatrix; subCmatrix];
        end

        % Rank of Control matrix = control centrality
        OC(actualNode) = sprank(observeMatrix);        
    end

end
