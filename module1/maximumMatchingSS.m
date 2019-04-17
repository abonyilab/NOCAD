function [ matched, unmatched, unmatchedSCC, matchedBy ] = maximumMatchingSS( adj )
%MAXIMUMMATCHINGSS calculates the maximum matching and then define
% additional nodes, which is part of unmatched SCCs. The function returns 
% with matched, unmatched, unmatchedSCC and matchedBy vectors. Vector 
% unmatchedSCC contains a node from each unmatched SCC, while the i. 
% element of matchedBy is the node, which matched the i. node.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[0 1 0 0;0 0 1 0;1 0 0 1;0 0 0 0];   % could be sparse
% ##################
% Function Calling:
%
% [matched, unmatched, unmatchedSCC, matchedBy]=maximumMatchingSS(adj)
% ##################
% Outputs:
%
% matched =
%      2     3
% 
% unmatched =
%      4
%      
% unmatchedSCC =
%      1
% 
% matchedBy =
%      3     1     2     0
% ##################
%  The algorithm was implemented by Daniel Leitold 

% add matlab_bgl to find components
if ~exist('components', 'file')
  mfilepath=fileparts(which('maximumMatchingSS'));
  addpath([mfilepath,'\..\matlab_bgl']);
end

% execute maximum matching
[matched, unmatched, matchedBy]=maximumMatching(adj);
% declare unmatchedSCC
unmatchedSCC=[];

% correct some matching value because of SCC
% find SCCs
if issparse(adj)
    compID=components(adj)';
else
    compID=components(sparse(adj))';
end

% size of components
[numOfID, ID]=hist(compID, 1:max(compID));

% find the components with more than one node
comps=ID(find(numOfID>1));

% add selfloops to comps
% loops
loops=find(diag(adj)~=0);

% add loops' component ID
comps=union(comps, compID(loops));

% check the SCCs
for ID=unique(comps)
    actualNodes=find(compID==ID);
    % start nodes to SCC
    incoming=setdiff(find(sum(adj(:,actualNodes),2)~=0), actualNodes);
    if(~isempty(intersect(matchedBy(actualNodes),0)))
        incoming=[incoming;0];
    end
    
    % if a cycle(SCC) has no input, then we should select one of the nodes
    if (isempty(incoming))
            unmatchedSCC=[unmatchedSCC, actualNodes(1)];
            matched=setdiff(matched, actualNodes(1));
    end
end

end

