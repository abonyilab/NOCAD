function [ betweenness ] = nodeBetweenness( adj )
%NODEBETWEENNESS returns with the betweenness centrality of the nodes in
% the network described with adj. The function uses MatlabBGL toolbox's
% betweenness_centrality function. The input matrix is directed and could
% be both weighted or unweighted.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[0 2 0; 2 0 2; 0 2 0];        % could be sparse
% ##################
% Function Calling:
%
% betweenness=nodeBetweenness(adj)
% ##################
% Output:
%
% betweenness =
%      0     2     0
% ##################
%  The algorithm was implemented by Daniel Leitold 

    mfilepath=fileparts(which('nodeBetweenness'));
    addpath(fullfile(mfilepath,'../matlab_bgl'));
    
    betweenness=betweenness_centrality(sparse(adj))';

end
