function [ matched, unmatched, matchedBy ] = maximumMatching( adj )
%MATCHING calculates maximum matching and returns with the set of the matched
%nodes, the set of the unmatched nodes and the matching itself (the i. node
%matched by the i. element of matchedBy)
% ##################
% Example:
% ##################
% Input: 
%
% adj=[0 1 0 0;0 0 1 0;1 0 0 1;0 0 0 0];  % could be sparse
% ##################
% Function Calling:
%
% [matched, unmatched, matchedBy]=maximumMatching(adj)
% ##################
% Outputs:
%
% matched =
%      1     2     3
% unmatched =
%      4
% matchedBy =
%      3     1     2     0
% ##################
%  The algorithm was implemented by Daniel Leitold 

% matching
matchedBy=dmperm(adj);

% matched nodes
matched=find(matchedBy~=0);

% unmatched nodes
unmatched=find(matchedBy==0);

end

