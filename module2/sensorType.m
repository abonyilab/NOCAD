function [ source, external, internal, inaccessible ] = sensorType( Amatrix, Cmatrix )
%SENSORTYPE categorizes the sensor nodes based on its structual position:
% source: if it has no input edges
% external dilation: if it has no output edges, i.e. it observe only itself
% internal dilation: if a set of nodes have more children then theirself
% inaccesible: if a node has input edges, but no observing can reach it,
%              and not an internal dilation
% The definitions above refers to the graph defined by the state transition
% matrix, i.e. the A matrix.
% ##################
% Example:
% ##################
% Inputs: the input matrices could be sparse
%
% Amatrix=[
%  0 0 0 0 0 0 0 0 0
%  1 0 0 0 0 1 0 0 0
%  0 1 0 0 0 0 0 0 0
%  0 1 0 0 0 0 0 0 0
%  0 0 1 1 0 0 0 0 0
%  0 0 0 0 0 0 0 0 0
%  0 0 0 0 1 0 0 0 0
%  0 1 0 0 0 0 0 0 1
%  0 0 0 0 0 0 0 1 0];
% Cmatrix=[
% 0 0 0 1 0 0 0 0 0
% 0 0 0 0 0 1 0 0 0
% 0 0 0 0 0 0 1 0 0
% 0 0 0 0 0 0 0 1 0];
% ##################
% Function Calling:
%
% [source, external, internal, inaccessible]=sensorType(Amatrix, Cmatrix)
% ##################
% Outputs:
%
% source =
%      0     0     0     0     0     0     1     0     0
%      
% external =
%      0     0     0     0     0     1     0     0     0
% 
% internal =
%      0     0     0     1     0     0     0     0     0
% 
% inaccessible =
%      0     0     0     0     0     0     0     1     0
% ##################
%  The algorithm was implemented by Daniel Leitold 


    % adj = matrix A - this change the meaning of in and out degree.
    adj=Amatrix;
    sensors=sensorNodes(Cmatrix);
    numNodes=numOfNodes(adj);
    % no input edges nodes
    zeroIn=sum(adj,1)==0;
    % no output edges nodes
    zeroOut=sum(adj,2)'==0;
    % source sensor nodes have no input edges
    source=sensors&zeroIn;
    % external dilation happen where no output edges
    external=sensors&zeroOut;
    % remove sources and externals from sensor nodes
    remainSensor=find((sensors&~source&~external)~=0);
    % declare the remain two output variables
    if issparse(Amatrix)
        internal=sparse([],[],1,1,numNodes);
        inaccessible=sparse([],[],1,1,numNodes);
    else
        internal=zeros(1,numNodes);
        inaccessible=zeros(1,numNodes);
    end
    for idxI=remainSensor
        %check if it is an internal dilation (more children than parents)
        parents=find(adj(:,idxI)~=0);
        prevParents=[];
        children=[];
        while(~isequal(parents, prevParents))
            prevParents=parents;
            children=find(sum(adj(parents,:),1)~=0);
            parents=find(sum(adj(:,children),2)'~=0);
        end
        if(length(children)>length(parents))
            inter=true;
        else
            inter=false;
        end
        % optimization posibilities: all children in remainSensor is internal
        % dilation and do not have to check them again.
        if inter
            internal(idxI)=1;
        else
            inaccessible(idxI)=1;
        end
    end
end


