function [ r ] = pearsonDir( adj, type )
%PEARSONDIR calculates the Pearson coefficient to the network described
% with adj. This function expects a directed network, so the calculated
% correlation type is needed:
%   type: 1: in-in, 2: in-out, 3: out-out, 4: out-in
% ##################
% Example:
% ##################
% Input: 
%
% adj=[
%  0 0 0 0 0
%  0 1 0 1 0
%  1 1 1 0 0
%  0 1 0 0 0
%  1 1 1 1 0];
% ##################
% Function Calling:
%
% rInIn=pearsonDir(adj, 1)
% rInOut=pearsonDir(adj, 2)
% rOutOut=pearsonDir(adj, 3)
% rOutIn=pearsonDir(adj, 4)
% ##################
% Output:
%
% rInIn =
%     0.2182
%     
% rInOut =
%     0.0262
% 
% rOutOut =
%    -0.0981
% 
% rOutIn =
%    -0.4082
% ##################
%  The algorithm was implemented by Daniel Leitold 

    [from, to]=find(adj);
    switch type
      case 1
        degF=sum(adj~=0,1);
        degT=degF;
      case 2
        degF=sum(adj~=0,1);
        degT=sum(adj~=0,2)';
      case 3
        degF=sum(adj~=0,2)';
        degT=degF;
      case 4
        degF=sum(adj~=0,2)';
        degT=sum(adj~=0,1);
    end
    degFrom=degF(from);
    degTo=degT(to);
    
    denom=sumSq(degFrom, degFrom)*sumSq(degTo, degTo);
    if denom>0
        r=(sumSq(degFrom, degTo))/sqrt(denom);
    else
        r=NaN;
    end
end

