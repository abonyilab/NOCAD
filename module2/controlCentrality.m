function [ CC ] = controlCentrality( Amatrix, Bmatrix )
%CONTROLCENTRALITY calculates the centrality measures from the A and B
% matrices. The output is a N length vector, where element i. is the
% centrality value of the state i. The non-driver nodes' centrality value
% are zero.
% ##################
% Example:
% ##################
% Inputs: 
%
% Amatrix=[1 0; 1 0];           % could be sparse
% Bmatrix=[1; 0];               % could be sparse
% ##################
% Function Calling:
% 
% [CC]=controlCentrality(Amatrix, Bmatrix)
% ##################
% Output:
%
% CC =
%      2     0
% ##################
%  The algorithm was implemented by Daniel Leitold 

    numOfNodes=numNodes(Amatrix);
    CC=zeros(1,numOfNodes);
    driverNodes=find(sum(Bmatrix,2)~=0)';

    % Iterate over driver nodes
    for actualNode=driverNodes
        % Generate the b vector for i. driver node
        subBmatrix=sparse([],[],1,numOfNodes,1);
        subBmatrix(actualNode)=1;
        
        % calculate modified controllability matrix: [b Ab .. A^(N-1)b]
        controlMatrix=subBmatrix;
        for idxI=1:numOfNodes-1
            subBmatrix=Amatrix*subBmatrix;
            controlMatrix=[controlMatrix, subBmatrix];
        end

        % Rank of Control matrix = control centrality
        CC(actualNode) = sprank(controlMatrix);

   end

end

