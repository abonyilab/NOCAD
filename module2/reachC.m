function [ controllable ] = reachC( Amatrix )
%REACHC funtion generates a reachability matrix for the A matrix.
% The intput adjacency matrix could be weighted and
% unweighted, but should be directed. The output matrix shows which node
% can control one, i.e. the i. column shows which nodes can control node i. 
% ##################
% Example:
% ##################
% Input: 
%
% Amatrix=[0 0 1 0; 1 0 0 0; 0 1 0 0; 0 0 1 0];     % could be sparse
% ##################
% Function Calling:
%
% controllable=reachC(Amatrix)
% ##################
% Output:
%
% controllable =
%      1     1     1     1
%      1     1     1     1
%      1     1     1     1
%      0     0     0     1
% ##################
%  The algorithm was implemented by Daniel Leitold 

controllable=+reachability(Amatrix');

end

