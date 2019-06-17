function [ similarityEndp ] = endpointSim( adj )
%ENDPOINTSIM generates a sparse matrix, which contains the similarity of
% the endpoints of the edges. The input is an adjacency or sparse matrix, 
% directed and could be weighted and unweighted. The endpointSim's size
% is NxN, and the i. row and j. column show the similarity of nodes i and j
% if there is an edge from i to j. The similarity is based on how many nodes
% are reachable from the endpoints of the edges, and how many nodes reach 
% the endpoints.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[0 1 0 1; 0 0 1 0; 0 0 0 0; 0 0 0 0];     % could be sparse
% ##################
% Function Calling:
%
% [similarityEndp]=endpointSim(adj)
% ##################
% Outputs:
%
% similarityEndp =
%    (1,2)       0.2500
%    (2,3)       0.3333
%    (1,4)       0.1250
% ##################
%  The algorithm was implemented by Daniel Leitold 


% Out - control reachability
 reachOut = reachability(adj);

 % In - observe reachability
 reachIn = reachOut' ;
 
 % Determine the edges
 [from, to]=find(adj);
 
 numNodes=numOfNodes(adj);
 numEdges=numOfEdges(adj);
 similarityEndp=sparse(zeros(numNodes));
 
 for idxI=1:numEdges
    % The edge's start- and endpoints reachabality sets
    fromIn=reachIn(from(idxI),:);
    fromOut=reachOut(from(idxI),:);
    toIn=reachIn(to(idxI),:);
    toOut=reachOut(to(idxI),:);
     
    % similarity
    similarityEndp(from(idxI), to(idxI))=...
        jaccard(fromIn, toIn) *...
        jaccard(fromOut, toOut);
 end
end

