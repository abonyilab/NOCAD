function [ betw ] = betweenness( adj )
%BETWEENNESS returns with the edge betweenness centrality of the network
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
% betw=betweenness(adj)
% ##################
% Output:
%
% betw =
% 
%    (2,1)        2
%    (1,2)        2
%    (3,2)        2
%    (2,3)        2
% ##################
%  The algorithm was implemented by Daniel Leitold 
  
   if ~exist('edgeBetweenness', 'file')
      mfilepath=fileparts(which('betweenness'));
      addpath([mfilepath,'\..\octave-networks-toolbox']);
   end
   
   numOfNodes = length(adj);
   betw=edgeBetweenness(adj);
   betw = sparse(betw(:,1), betw(:,2),...
       betw(:,3)*numOfNodes*(numOfNodes-1), numOfNodes, numOfNodes);

end

