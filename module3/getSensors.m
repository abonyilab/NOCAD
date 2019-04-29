function [ nodes ] = getSensors( A )
%GETSENSORS generates driver nodes for adjacency matrix A, or sensor nodes
% for state-transition matrix A. It ensures structural controllability or
% observability with minimum number of drivers or sensors.
% ##################
% Example:
% ##################
% Input: 
%
% A = [0 1 0 0; 0 0 1 0; 1 0 0 1; 0 0 0 0];
% ##################
% Function Calling:
% 
% [ nodes ] = getSensors( A )
% ##################
% Output:
%
% nodes =
%      1
% ##################
%  The algorithm was implemented by Daniel Leitold 

% add matlab_bgl to find components
if ~exist('components', 'file')
   mfilepath=fileparts(which('getSensors'));
   addpath([mfilepath,'\..\module1']);
end

% execute maximum matching
matchedBy=dmperm(A);

% correct some matching value because of SCC
% find SCCs
if issparse(A)
    compID=components(A)';
else
    compID=components(sparse(A))';
end

% size of components
[numOfID, ID]=hist(compID, 1:max(compID));

% find the components with more than one node
comps=ID(find(numOfID>1));

% add selfloops to comps
% loops
loops=find(diag(A)~=0);

% add loops' component ID
comps=union(comps, compID(loops));

% declare removable edges
numOfNodes=length(matchedBy);
removable=sparse([],[],1,numOfNodes, numOfNodes);

% check the SCCs
for ID=unique(comps)
    actualNodes=find(compID==ID);
    % start nodes to SCC
    incoming=setdiff(find(sum(A(:,actualNodes),2)~=0), actualNodes);
    if(~isempty(intersect(matchedBy(actualNodes),0)))
        incoming=[incoming;0];
    end
    % target nodes from SCC
    outgoing=setdiff(find(sum(A(actualNodes,:),1)~=0), actualNodes);
    
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
                        find(A(:,uncontrolled(1))~=0));
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
nodes = find(matchedBy==0);


end

