function [ ] = heatmaps( A, iteration )
%HEATMAPS generates two heat maps for system described by A. The function
% calculates the each loop-symmetry pair <iteration> times, and calculates
% the mean of these results. The function shows the two figures.
% ##################
% Example:
% ##################
% Input: 
%
% A=[
% 0 1 1 1 1 1 1 1;
% 0 0 0 0 0 0 0 0;
% 1 0 0 0 0 0 0 0;
% 1 0 0 1 0 0 0 0;
% 0 0 0 0 0 0 0 0;
% 0 0 0 0 0 1 0 0;
% 0 0 0 0 0 0 0 0;
% 0 0 0 0 0 0 0 0];        % could be sparse
% iteration = 5;
% ##################
% Function Calling:
%
% heatmaps( A, iteration )
% ##################
% Output:
% # 2 figures #
% ##################
%  The algorithm was implemented by Daniel Leitold 

% Add functions of module 2
if ~exist('percentLoopSym', 'file')
   mfilepath=fileparts(which('heatmaps'));
   addpath(genpath([mfilepath,'\..\module2']));
end

%% Change matrix A to logical
A=A~=0;

%% Get the basic percent of loops and symmetries
% Use the percentLoopSym function from NOCAD module2
[ percentLoop, percentSym ] = percentLoopSym( A );
%% Notation
% Since with heatmap the zero value cannot be presented (there is no zero
% index for a matrix), we change the percentage interval from 0 - 100 to 
% 1 - 101
percentLoop=percentLoop+1;
percentSym=percentSym+1;

%% Get the free loop edges and symmetric edges
freeLoop=find(diag(A)==0);
freeSym=(((A+A')==1)-A)>0;
[from, to]=find(freeSym);
freeSym=[from,to];
clear from;
clear to;

%% Get the original number of driver and sensor
[numOfDriver, numOfSensor]=getNodes(A);


%% Declar maps. Set the values for loops and symmetries, that smaller than original
mapD=zeros(101,101);
mapD((1:round(percentLoop)-1),:)=numOfDriver;       % -1 means that the necessary drivers can be smaller at the originally given loop
mapD(:,(1:round(percentSym)-1))=numOfDriver;

mapS=zeros(101,101);
mapS((1:round(percentLoop)-1),:)=numOfSensor;
mapS(:,(1:round(percentSym)-1))=numOfSensor;

%% Convert the map to edge list
[tmpFrom, tmpTo, tmpVal] = find(mapD);
if iscolumn(tmpFrom)
    mapD = [tmpFrom, tmpTo, tmpVal];
    [tmpFrom, tmpTo, tmpVal] = find(mapS);
    mapS = [tmpFrom, tmpTo, tmpVal];
else
    mapD = [tmpFrom', tmpTo', tmpVal'];
    [tmpFrom, tmpTo, tmpVal] = find(mapS);
    mapS = [tmpFrom', tmpTo', tmpVal'];
end

%% Check if the possible added nodes or edges grater than 100
numOfNodes = length(freeLoop);
numOfEdges = length(freeSym);
remNode = 101-ceil(percentLoop);    
remEdge = 101-ceil(percentSym);   
if numOfNodes>remNode
    weightOfANode = remNode/numOfNodes;
    nodeList=0;
    for idxI=1:remNode;
        nodeList=[nodeList, round(idxI/weightOfANode)];
    end
else
    nodeList=0:numOfNodes;
end
if numOfEdges>remEdge
    weightOfAnEdge = remEdge/numOfEdges;
    edgeList=0;
    for idxI=1:remEdge;
        edgeList=[edgeList, round(idxI/weightOfAnEdge)];
    end
else
    edgeList=0:numOfEdges;
end

%% Add new edges, and update heatmap
for loopI=nodeList
    fprintf('%d/%d\n',find(loopI==nodeList),length(nodeList));
    disp(datestr(now))
    for symI=edgeList
        loop=[];
        sym=[];
        driv=[];
        sen=[];
        for id=1:iteration
            tmpA = addEdges(A, freeLoop, freeSym, loopI, symI);
            [pLoop,pSym] = percentLoopSym(tmpA);
            loop=[loop, pLoop+1];
            sym=[sym, pSym+1];
            [nDriv, nSen] = getNodes(tmpA);
            driv=[driv, nDriv];
            sen=[sen, nSen];
        end
        mapD=[mapD; mean(loop), mean(sym), mean(driv)];
        mapS=[mapS; mean(loop), mean(sym), mean(sen)];
    end
end



%% round percentages
mapD = [round(mapD(:,1)), round(mapD(:,2)), mapD(:,3)];
mapS = [round(mapS(:,1)), round(mapS(:,2)), mapS(:,3)];
[map1, ~, map2] = unique(mapD(:,[1 2]), 'rows');
mapD = [map1, accumarray(map2, mapD(:,3), [], @mean)];
[map1, ~, map2] = unique(mapS(:,[1 2]), 'rows');
mapS = [map1, accumarray(map2, mapS(:,3), [], @mean)];

%% create heat map data
driverHeatMap = sparse(mapD(:,1), mapD(:,2), mapD(:,3), 101, 101);
sensorHeatMap = sparse(mapS(:,1), mapS(:,2), mapS(:,3), 101, 101);


%% Hide missed data
looprange=round(percentLoop):101;
symrange=round(percentSym):101;
for idxI=2:101
    if ~any(driverHeatMap(looprange,idxI))
        driverHeatMap(looprange,idxI)=driverHeatMap(looprange,idxI-1);
    end
    if ~any(sensorHeatMap(looprange,idxI))
        sensorHeatMap(looprange,idxI)=sensorHeatMap(looprange,idxI-1);
    end
end
for idxI=2:101
    if ~any(driverHeatMap(idxI,symrange))
        driverHeatMap(idxI,symrange)=driverHeatMap(idxI-1,symrange);
    end
    if ~any(sensorHeatMap(idxI,symrange))
        sensorHeatMap(idxI,symrange)=sensorHeatMap(idxI-1,symrange);
    end
end

%% Plot heatmaps
% Drawing drivers
figure(1)
imagesc(driverHeatMap);
title('Number of neccessary driver nodes depending on loops and symmetries');
set(gca,'YDir','normal');
xlabel('Percent of interaction');
ylabel('Percent of self-influencing');
cbar=colorbar();
colormap('Hot')
ylabel(cbar,'Number of driver nodes');

% Drawing sensors
figure(2)
imagesc(sensorHeatMap);
title('Number of neccessary sensor nodes depending on loops and symmetries');
set(gca,'YDir','normal');
xlabel('Percent of interaction');
ylabel('Percent of self-influencing');
cbar=colorbar();
colormap('Hot')
ylabel(cbar,'Number of sensor nodes');
end

