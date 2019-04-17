function [ drivers ] = driverNodes( Bmatrix )
%DRIVERNODES functions returns with drivers vector, where the i.
%element is 1 if the i. state is a driver node, 0 otherwise. The input
%is the B matrix of the linear system.
% ##################
% Example:
% ##################
% Input: 
%
% Bmatrix=[1 0; 0 0; 0 0; 0 1];     % could be sparse
% ##################
% Function Calling:
%
% drivers=driverNodes(Bmatrix)
% ##################
% Output:
%
% drivers =
%      1     0     0     1
% ##################
%  The algorithm was implemented by Daniel Leitold 

  drivers=+(sum(Bmatrix,2)~=0)';

end

