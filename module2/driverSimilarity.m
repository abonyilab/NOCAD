function [ drivSimilarity ] = driverSimilarity( Amatrix, Bmatrix )
%DRIVERSIMILARITY funciton creates the similarity of the driver nodes
% of the linear system describe by input Amatrix and Bmatrix. The function
% use the jaccard similarity to determines how similar the controlled
% nodes, which are controlled by the driver nodes. In the output matrix 
% row i. and column j. contains the similarity of control node i and j.
% If at least one of them are not a control node, then the similarity is 0.
% ##################
% Example:
% ##################
% Inputs: 
%
% Amatrix=[0 0 0 0; 1 0 0 0; 0 1 0 0; 1 0 0 0];     % could be sparse
% Bmatrix=[1 0; 0 0; 0 0; 0 1];                     % could be sparse
% ##################
% Function Calling:
%
% drivSimilarity=driverSimilarity(Amatrix, Bmatrix)
% ##################
% Output:
%
% drivSimilarity =
%     1.0000         0         0    0.1667
%          0         0         0         0
%          0         0         0         0
%     0.1667         0         0    1.0000
% ##################
%  The algorithm was implemented by Daniel Leitold 

    % Declare variables
    numOfStates=numNodes(Amatrix);
    if issparse(Amatrix)
        drivSimilarity=sparse([],[],1,numOfStates, numOfStates);
    else
        drivSimilarity=zeros(numOfStates);
    end
    drivers=find(driverNodes(Bmatrix)~=0);    
    controlling=clusterControl(Amatrix, Bmatrix);
    
    % Determine similarity
    for con1=drivers
        for con2=drivers
            drivSimilarity(con1,con2)=...
                jaccard(controlling(:,con1),controlling(:,con2));
            % Weighting
            weighting=simWeighting(controlling(:,con1)',controlling(:,con2)');
            drivSimilarity(con1, con2)=drivSimilarity(con1, con2)*weighting;
        end
    end
end

