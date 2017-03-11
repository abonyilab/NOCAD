function [ col ] = genCol( netw, name )
%GENCOL generates a column of a comparison table. The columns contain
% informations about the network. The generated measures can be seen below. 
% If netw equal 0, then the measures' names are returned.
%  The algorithm was implemented by Daniel Leitold 


    if ~isstruct(netw)
        % Generated measures
        col={...
            'Network';...
            'number of nodes';...
            'number of edges';...
            'density';...
            'diameter';...
            'relative degree';...
            'mean of degree';...
            'number of driver nodes';...
            'number of source driver nodes';...
            'number of external driver nodes';...
            'number of internal driver nodes';...
            'number of inaccessible driver nodes';...
            'number of sensor nodes';...
            'number of source sensor nodes';...
            'number of external sensor nodes';...
            'number of internal sensor nodes';...
            'number of inaccessible sensor nodes';...
            'Pearson correlation in-in';...
            'Pearson correlation in-out';...
            'Pearson correlation out-out';...
            'Pearson correlation out-in';...
            'percent of driver nodes';...
            'percent of sensor nodes';...
            'percent of loops';...
            'percent of symmetries'};
    else
        numOfAttr=25;

        % Declaration
        col=cell(numOfAttr,1);

        % Generating
            %  1: name
            col(1)={name};
            %  2: number of nodes
            col(2)={netw.system.measure.numOfNodes};
            %  3: number of edges
            col(3)={netw.system.measure.numOfEdges};
            %  4: density
            col(4)={netw.system.measure.density};
            %  5: diameter
            col(5)={netw.system.measure.diameter};
            %  6: relative degree
            col(6)={netw.system.measure.degreeRelative};
            %  7: mean of degree
            col(7)={mean(netw.node.centrality.degree)};
            %  8: number of driver nodes
            col(8)={sum(netw.node.cluster.driverNodes)};
            %  9: number of source driver nodes
            col(9)={sum(netw.node.cluster.driverSource)};
            % 10: number of external driver nodes
            col(10)={sum(netw.node.cluster.driverExternal)};
            % 11: number of internal driver nodes
            col(11)={sum(netw.node.cluster.driverInternal)};
            % 12: number of inaccessible driver nodes
            col(12)={sum(netw.node.cluster.driverInaccess)};
            % 13: number of sensor nodes
            col(13)={sum(netw.node.cluster.sensorNodes)};
            % 14: number of source sensor nodes
            col(14)={sum(netw.node.cluster.sensorSource)};
            % 15: number of source external nodes
            col(15)={sum(netw.node.cluster.sensorExternal)};
            % 16: number of source internal nodes
            col(16)={sum(netw.node.cluster.sensorInternal)};
            % 17: number of source inaccessible nodes
            col(17)={sum(netw.node.cluster.sensorInaccess)};
            % 18: Pearson correlation in-in
            col(18)={netw.system.measure.rInIn};
            % 19: Pearson correlation in-out
            col(19)={netw.system.measure.rInOut};
            % 20: Pearson correlation out-out
            col(20)={netw.system.measure.rOutOut};
            % 21: Pearson correlation out-in
            col(21)={netw.system.measure.rOutIn};
            % 22: percent of driver nodes
            col(22)={100*(sum(netw.node.cluster.driverNodes))/...
                netw.system.measure.numOfNodes};
            % 23: percent of sensor nodes
            col(23)={100*(sum(netw.node.cluster.sensorNodes))/...
                netw.system.measure.numOfNodes};
            % 24: percent of loops
            col(24)={netw.system.measure.percentLoops};
            % 25: percent of symmetries
            col(25)={netw.system.measure.percentSym};

    end
end

