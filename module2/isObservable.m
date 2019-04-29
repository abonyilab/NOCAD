function [ observable ] = isObservable( Amatrix, Cmatrix )
%ISOBSERVABLE checks if the system is observable according to the
% given adjacency matrices A and C. The function generates the 
% observability matrix O=[C; CA; ...; CA^(N-1)], where N is the number of
% states. If the rank(O)=N, then the system is observable, the output is
% logical 1, otherwise 0.
% ##################
% Example:
% ##################
% Inputs: 
%
% Amatrix=[0 0 0; 1 0 0; 1 0 0];    % could be sparse
% Cmatrix=[0 1 0; 0 0 1];           % could be sparse
% ##################
% Function Calling:
%
% observable=isObservable(Amatrix, Cmatrix)
% ##################
% Output:
%
% observable =
% 
%      1
% ##################
%  The algorithm was implemented by Daniel Leitold 

    % define N, i.e. the number of nodes
    numberOfNodes=numNodes(Amatrix);

    % observability matrix: O=[C; CA; ... ; CA^(N-1)]
    tempMatrix=Cmatrix;
    ObserveMatrix=Cmatrix;
    for idxI=1:numberOfNodes-1
        tempMatrix=tempMatrix*Amatrix;
        ObserveMatrix=[ObserveMatrix; tempMatrix];
    end
    
    % determine rank(O)
    rankOM = sprank(ObserveMatrix);
    
    % return value
    if (numberOfNodes == rankOM)
        observable=true;
    else
        observable=false;
    end

end

