function [ observable ] = reachO( Amatrix )
%REACHO funtion generates a reachability matrix for the A matrix.
% The intput adjacency matrix could be weighted and
% unweighted, but should be directed. The output matrix shows which node
% can be observed, i.e. the i. rows shows wihch nodes can reach the i.
% node, i.e. which one can be observed by node i. Another approach is that,
% the i. column shows, which nodes can observe node i. 
% ##################
% Example:
% ##################
% Input: 
%
% Amatrix=[0 0 1 0; 1 0 0 0; 0 1 0 0; 0 0 1 0];     % could be sparse
% ##################
% Function Calling:
%
% observable=reachO(Amatrix)
% ##################
% Output:
%
% observable =
%      1     1     1     0
%      1     1     1     0
%      1     1     1     0
%      1     1     1     1
% ##################
%  The algorithm was implemented by Daniel Leitold 

observable=+reachability(Amatrix);

end

