function [ betweenness ] = edgeBetweenness( adj )
%EDGEBETWEENNESS returns with the betweenness centrality of the network
% described with adj. The function uses MatlabBGL toolbox's
% betweenness_centrality function. The input matrix sould be directed,
% and could be wighted and unweighted.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[0 2 0; 2 0 2; 0 2 0];        % could be sparse
% ##################
% Function Calling:
%
% betweenness=edgeBetweenness(adj)
% ##################
% Output:
%
% betweenness =
% 
%    (2,1)        2
%    (1,2)        2
%    (3,2)        2
%    (2,3)        2
% ##################
%  The algorithm was implemented by Daniel Leitold 
  
   mfilepath=fileparts(which('edgeBetweenness'));
   addpath(fullfile(mfilepath,'../matlab_bgl'));
   [~,betweenness]=betweenness_centrality(sparse(adj));

end

