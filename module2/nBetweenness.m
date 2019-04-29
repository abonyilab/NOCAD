function [ betweenness ] = nBetweenness( adj )
%NODEBETWEENNESS returns with the betweenness centrality of the nodes in
% the network described with adj. The function uses octave networks toolbox's
% functions. The input matrix is directed and could be both weighted or
% unweighted.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[0 2 0; 2 0 2; 0 2 0];        % could be sparse
% ##################
% Function Calling:
%
% betweenness=nBetweenness(adj)
% ##################
% Output:
%
% betweenness =
%      0     2     0
% ##################
%  The algorithm was implemented by Daniel Leitold.

if ~exist('nodeBetweennessFaster', 'file')
   mfilepath=fileparts(which('nodeBetweenness'));
   addpath([mfilepath,'\..\octave-networks-toolbox']);
end
    
    
betweenness = nodeBetweennessFaster(adj)*(2*nchoosek(size(adj,1),2));

end

