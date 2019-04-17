function [ similarityEdge, edges ] = similarity( adj )
%SIMILARITY generates a matrix, which is contain the similarity of the
% edges. The input is an adjacency or sparse matrix, which is directed and 
% could be weighted and unweighted. The output similarity's size is 
% |E|x|E|, and the i.-th row and j.-th coloumn shows how similar the edge
% i. and j. The sequence of the edges are given by the vector edges,
% where edges(i, 1) the startpoint, and edges(i,2) the endpoint of the edge
% i. The similarity is based on how many nodes are reacable from the
% endpoints of the edges, and how many nodes reach them.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[0 1 0 1; 0 0 1 0; 0 0 0 0; 0 0 0 0];     % could be sparse
% ##################
% Function Calling:
%
% [similarityEdge, edges]=similarity(adj)
% ##################
% Outputs:
%
% similarityEdge = 
%     1.0000    0.0833         0
%     0.0833    1.0000         0
%          0         0    1.0000
% edges =
%      1     2
%      2     3
%      1     4
% ##################
%  The algorithm was implemented by Daniel Leitold 

 % Out - who is reachable
 reachOut = reachability(adj);

 % In - who can reach
 reachIn = reachOut' ;
 
 % Determine the edges
 [from, to]=find(adj);
 edges=[from, to];
 
 numOfEdges=numEdges(adj);
 similarityEdge=zeros(numOfEdges);
 
 for idxI=1:numOfEdges-1
     % First edge's start- and endpoints reachabality sets
     fromIn=reachIn(from(idxI),:);
     fromOut=reachOut(from(idxI),:);
     toIn=reachIn(to(idxI),:);
     toOut=reachOut(to(idxI),:);
     for idxJ=idxI+1:numOfEdges
        % Second edge's start- and endpoints reachabality sets
        fromIn2=reachIn(from(idxJ),:);
        fromOut2=reachOut(from(idxJ),:);
        toIn2=reachIn(to(idxJ),:);
        toOut2=reachOut(to(idxJ),:);
        
        % Similarity
        similarityEdge(idxI,idxJ)=...
            (jaccard(fromIn, fromIn2) *...
            jaccard(toOut, toOut2))*...
            (jaccard(toIn, toIn2)*...
            jaccard(fromOut, fromOut2))...
            ;
     end
 end
 similarityEdge=similarityEdge+similarityEdge'+eye(numOfEdges);
 if issparse(adj)
     similarityEdge=sparse(similarityEdge);
 end
 
end

