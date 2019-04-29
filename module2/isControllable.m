function [ controllable ] = isControllable( Amatrix, Bmatrix )
%ISCONTROLLABLE checks if the system is controlable according to the
% given adjacency matrices A and B. The function generates the 
% controllability matrix C=[B AB ... A^(N-1)B], where N is the number of
% states. If the rank(C)=N, then the system is controllable, the output is
% logical 1, otherwise 0.
% ##################
% Example:
% ##################
% Inputs: 
%
% Amatrix=[0 0 0; 1 0 0; 1 0 0];       % could be sparse
% Bmatrix=[1 0; 0 0; 0 1];             % could be sparse
% ##################
% Function Calling:
%
% controllable=isControllable(Amatrix, Bmatrix)
% ##################
% Output:
%
% controllable =
% 
%      1
% ##################
%  The algorithm was implemented by Daniel Leitold 

    % define N, i.e. the number of nodes
    numberOfNodes=numNodes(Amatrix);

    % generate controlability matrix: C=[B AB .. A^(N-1)B]
    tempMatrix=Bmatrix;
    ControlMatrix=Bmatrix;
    for idxI=1:numberOfNodes-1
        tempMatrix=Amatrix*tempMatrix;
        ControlMatrix=[ControlMatrix, tempMatrix];
    end
    
    % determine rank(C)
    rankCM = sprank(ControlMatrix);
    
    % return value
    if (numberOfNodes == rankCM)
        controllable=true;
    else
        controllable=false;
    end

end

