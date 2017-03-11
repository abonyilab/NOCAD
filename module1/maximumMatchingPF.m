function [ matched, unmatched, matchedBy, removable ] = maximumMatchingPF( adj )
%MAXIMUMMATCHINGPF calculates the maximum matching and then corrects
% it for controllability and observability. If there is an unmatched SCC,
% then it will controlled by an input signal such that, if there is an edge
% from the SCC to an unmatched node, then the unmatched node will be 
% matched by the SCC. The function returns with matched, unmatched and 
% matchedBy vector, where the i. node matched by the i. element of 
% matchedBy. The fourth output is removable, which is a sparse matrix,
% containing the edges, which can remove from the original network (adj) to
% provide a suitable matching for system's controllability, observability. 
% ##################
% Example:
% ##################
% Input: 
%
% adj=[0 1 0 0;0 0 1 0;1 0 0 1;0 0 0 0];   % could be sparse
% ##################
% Function Calling:
%
% [matched, unmatched, matchedBy, removable]=maximumMatchingPF(adj)
% ##################
% Outputs:
%
% matched =
%      2     3     4
% unmatched =
%      1
% matchedBy =
%      0     1     2     3
% removable =
%    (3,1)        1
% ##################
%  The algorithm was implemented by Daniel Leitold 

% add matlab_bgl to find components
mfilepath=fileparts(which('maximumMatchingPF'));
addpath(fullfile(mfilepath,'../matlab_bgl'));

% execute maximum matching
[~, ~, matchedBy]=maximumMatching(adj);

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

% declare removable edges
numOfNodes=length(matchedBy);
removable=sparse([],[],1,numOfNodes, numOfNodes);

% check the SCCs
for ID=unique(comps)
    actualNodes=find(compID==ID);
    % start nodes to SCC
    incoming=setdiff(find(sum(adj(:,actualNodes),2)~=0), actualNodes);
    if(~isempty(intersect(matchedBy(actualNodes),0)))
        incoming=[incoming;0];
    end
    % target nodes from SCC
    outgoing=setdiff(find(sum(adj(actualNodes,:),1)~=0), actualNodes);
    
    % type of SCC
    type=1*isempty(incoming)+2*isempty(outgoing);
    
    switch type
        case 0
            % incoming and outgoing node too
            % no intervention needed
        case 1
            % no incoming some outgoing node
            if(isempty(intersect(matchedBy(outgoing),actualNodes)))
                % uncontrolled outgoing nodes
                uncontrolled=intersect(outgoing, find(matchedBy==0));
                % if we have to intervene
                if(~isempty(uncontrolled))
                    possibleDriverNodes=intersect(actualNodes,...
                        find(adj(:,uncontrolled(1))~=0));
                    if(isempty(possibleDriverNodes))
                        matchedBy(actualNodes(1))=0;
                    else
                        % add removable edge
                        to=find(matchedBy==possibleDriverNodes(1));
                        from=matchedBy(to);
                        removable(from, to)=1;
                        % change matching
                        matchedBy(to)=0;
                        matchedBy(uncontrolled(1))=possibleDriverNodes(1);
                    end
                else
                    % if all outgoing node controlled than only one driver
                    % node necessary
                    from=matchedBy(actualNodes(1));
                    removable(from, actualNodes(1))=1;
                    matchedBy(actualNodes(1))=0;
                end
            else
                % the SCC controll a node, no intervention needed, only
                % one driver node necessary
                from=matchedBy(actualNodes(1));
                removable(from, actualNodes(1))=1;
                matchedBy(actualNodes(1))=0;
            end
        case 2
            % some incoming no outgoing node
            % no intervention needed            
        case 3
            % no incoming no outgoing node
            % one driver node needed
            from=matchedBy(actualNodes(1));
            removable(from, actualNodes(1))=1;
            matchedBy(actualNodes(1))=0;
    end    
end

% set output
matched=find(matchedBy~=0);
unmatched=find(matchedBy==0);


end

