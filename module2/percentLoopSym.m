function [ percentLoop, percentSym ] = percentLoopSym( adj )
%COUNTLOOPSYM determines the percentage of loops, i.e. the proportion of 
% number of loops and number of nodes, and the percentage of symmetric 
% edge-pair, i.e. the proportion of number of node-pair which has symmetric 
% edge-pair and the number of connected node-pair (loops are not counted).
% ##################
% Example:
% ##################
% Input: the input matrix could be sparse
%
% adj=[
% 1 1 0;
% 0 0 1;
% 0 1 0];
% ##################
% Function Calling:
%
% [percentLoop, percentSym]=percentLoopSym(adj)
% ##################
% Outputs:
% percentLoop =
%    33.3333
% 
% percentSym =
%    50
% ##################
%  The algorithm was implemented by Daniel Leitold 

    adj = adj~=0;
    numOfNodes = length(adj);
    numOfLoops = size(find(diag(adj)~=0),1);
    percentLoop = 100*numOfLoops/numOfNodes;
    
    edges = triu(adj+adj',1);
    assym = sum(edges(:)~=0);
    if assym == 0
        percentSym = 0;
    else
        sym = sum(edges(:)==2);
        percentSym = full(100*sym/assym);
    end
end

