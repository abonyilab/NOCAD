function [ edgeImportance ] = importance( adj )
%IMPORTANCE generates a sparse matrix, which is contain the importance of the
% edges. The input is an adjacency matrix, which is directed and could be
% weighted and unweighted. The edgeImportance's size is NxN, and the
% i. row and j. column show the importance of edges i->j. The importance
% is based on how many nodes are reacable from the endpoints of the 
% edges, and how many nodes reach the endpoints.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[0 1 0 1; 0 0 1 0; 0 0 0 0; 0 0 0 0];
% ##################
% Function Calling:
%
% [edgeImportance]=importance(adj)
% ##################
% Outputs:
%
% edgeImportance =
%    (1,2)       0.2500
%    (2,3)       0.3333
%    (1,4)       0.1250
% ##################
%  The algorithm was implemented by Daniel Leitold 


% Out - control reachability
 rOut = adj & 1;
 rOut = rOut | eye(size(rOut));
 reachOut = zeros(size(rOut)) ;
 while prod(prod(+(reachOut == rOut))) == 0
    reachOut = rOut ;
    rOut = rOut | (+rOut * +rOut) ;
 end 

 % In - Observe reachability
 reachIn = reachOut' ;
 
 % Determine the edges
 [from, to]=find(adj);
 
 numOfNodes=numNodes(adj);
 numOfEdges=numEdges(adj);
 edgeImportance=sparse(zeros(numOfNodes));
 
 for idxI=1:numOfEdges
    % The edge's start- and endpoints reachabality sets
    fromIn=reachIn(from(idxI),:);
    fromOut=reachOut(from(idxI),:);
    toIn=reachIn(to(idxI),:);
    toOut=reachOut(to(idxI),:);
     
    % Importance
    edgeImportance(from(idxI), to(idxI))=...
        jaccard(fromIn, toIn) *...
        jaccard(fromOut, toOut);
 end
end

