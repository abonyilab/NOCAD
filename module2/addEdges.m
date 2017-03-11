function [ A ] = addEdges( A, freeLoop, freeSym, numLoop, numSym)
%ADDEDGES function get a system described by A. Inputs freeLoop gives the
% nodes, with no loop, while freeSym is an edge list with the edges,
% that are not appearing in the network determined by A, but its symmetric
% pair is part of the network. numLoop and numSym is the number of the
% loops and the symmetric edge parts that user want to add the network.
% If numLoop or numSym greater than freeLoop or freeSym, then all free
% edges are added to network. The output is the changed A matrix.
% ##################
% Example:
% ##################
% Input: 
%
% A=[1 0 0; 1 0 0; 1 0 0];        % could be sparse
% freeLoop=find(diag(A)==0);
% freeSym=(((A+A')==1)-A)>0;
% [from, to]=find(freeSym);
% freeSym=[from,to];
% numLoop = 2;
% numSym = 5;
% ##################
% Function Calling:
%
% [ A ] = addEdges( A, freeLoop, freeSym, numLoop, numSym)
% ##################
% Output:
%
% A =
%      1     1     0
%      1     1     0
%      1     0     0
% ##################
%  The algorithm was implemented by Daniel Leitold 

% Number of free loops, symmetries and nodes
numOfFreeLoop = length(freeLoop);
numOfFreeSym = length(freeSym);
numOfNodes = length(A);

% Check if the number of new edges are higher than free edges
if numOfFreeLoop < numLoop
    numLoop = numOfFreeLoop;
end
if numOfFreeSym < numSym
    numSym = numOfFreeSym;
end

% Add loops
idx = randperm(numOfFreeLoop, numLoop);
nodes = freeLoop(idx);
tmp = sparse(nodes, nodes, 1, numOfNodes, numOfNodes);
A = A+tmp;

% Add symmetries
idx = randperm(numOfFreeSym, numSym);
edges = freeSym(idx, :);
tmp = sparse(edges(:,1), edges(:,2), 1, numOfNodes, numOfNodes);
A = A+tmp;

