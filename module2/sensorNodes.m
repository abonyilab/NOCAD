function [ observers ] = sensorNodes( Cmatrix )
%SENSORNODES functions returns with observers vector, where the i.
%element is 1 if the i. state is an observer node, 0 otherwise. The input
%is the C matrix of the linear system.
% ##################
% Example:
% ##################
% Input: 
%
% Cmatrix=[0 0 1 0; 0 0 0 1];       % could be sparse
% ##################
% Function Calling:
%
% observers=sensorNodes(Cmatrix)
% ##################
% Output:
%
% observers =
%      0     0     1     1
% ##################
%  The algorithm was implemented by Daniel Leitold 

  observers=+(sum(Cmatrix,1)~=0);

end

