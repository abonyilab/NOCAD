function [ reach ] = reachability( adj )
%REACHABILITY funtion generates a reachability matrix for the network adj.
% The intput adjacency or sparse matrix could be weighted and
% unweighted, but should be directed. The output matrix shows which node
% can be reached, i.e. the i. rows shows wihch nodes can be reached by 
% node i. Another approach is that, the i. column shows, which nodes can 
% reach node i. The output matrix is logical or sparse.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[0 1 0 0; 0 0 1 0; 1 0 0 1; 0 0 0 0];     % could be sparse
% ##################
% Function Calling:
%
% reach=reachability(adj)
% ##################
% Output:
%
% reach =
%      1     1     1     1
%      1     1     1     1
%      1     1     1     1
%      0     0     0     1
% ##################
%  The algorithm was implemented by Daniel Leitold 

 reach = adj & 1;
 reach = reach | speye(size(reach));
 temp = zeros(size(reach)) ;
 while ~all(temp == reach)
    temp = reach ;
    reach = reach | reach^2 ;
 end

end

