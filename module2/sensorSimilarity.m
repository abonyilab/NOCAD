function [ senSimilarity ] = sensorSimilarity( Amatrix, Cmatrix )
%SENSORSIMILARITY funciton creates the similarity of the sensor nodes
% of the linear system describe by input Amatrix and Cmatrix. The function
% use the jaccard similarity to determines how similar the observed
% nodes, which are observed by the sensor nodes. In the output matrix 
% the i. row and j. column contains the similarity of sensor node i and j.
% If at least one of them are not a sensor node, then the similarity is 0.
% ##################
% Example:
% ##################
% Inputs: 
%
% Amatrix=[0 0 0 0; 1 0 0 0; 0 1 0 0; 1 0 0 0];     % could be sparse
% Cmatrix=[0 0 1 0; 0 0 0 1];                       % could be sparse
% ##################
% Function Calling:
%
% senSimilarity=sensorSimilarity(Amatrix, Cmatrix)
% ##################
% Output:
%
% senSimilarity =
%          0         0         0         0
%          0         0         0         0
%          0         0    1.0000    0.1667
%          0         0    0.1667    1.0000
% ##################
%  The algorithm was implemented by Daniel Leitold 
  
    % Declare variables
    numOfStates=numNodes(Amatrix);
    if issparse(Amatrix)
        senSimilarity=sparse([],[],1,numOfStates, numOfStates);
    else
        senSimilarity=zeros(numOfStates);
    end
    sensors=find(sensorNodes(Cmatrix)~=0);
    observing=clusterObserve(Amatrix, Cmatrix);
    
    % Determine similarity
    for sen1=sensors
        for sen2=sensors
            senSimilarity(sen1,sen2)=...
                jaccard(observing(:,sen1),observing(:,sen2));
            % Weighting
            weighting=simWeighting(observing(:,sen1)',observing(:,sen2)');
            senSimilarity(sen1, sen2)=senSimilarity(sen1, sen2)*weighting;
        end
    end
end

