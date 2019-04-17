function [ relativeDegree ] = degreeRel( Amatrix, Bmatrix, Cmatrix )
%DEGREEREL function generates the relative degree of the given system
% determined by input A, B and C matrices of state-space model. The relative
% degree is the maximum of the relative degree of each output. The relative
% degree of an output is the minimum of geodesic paths between the output
% and all of inputs. If there is no path between a driver node
% - sensor node pair, then the length of the path is Inf. This measure can
% says that how many derives needed to appear the input signal on the output. 
% ##################
% Example:
% ##################
% Inputs: the input matrices could be sparse
%
% Amatrix=[
%  0 0 0 0 0;
%  1 0 0 0 0;
%  0 1 0 0 0;
%  0 0 1 0 0;
%  0 0 0 1 0];    
% Bmatrix=[
%  1 0;
%  0 0;
%  0 0;
%  0 1;
%  0 0];
% Cmatrix=[
%  0 1 0 0 0;
%  0 0 0 0 1];
% ##################
% Function Calling:
%
% [relativeDegree]=degreeRel(Amatrix, Bmatrix, Cmatrix)
% ##################
% Outputs:
%
% relativeDegree =
%      1
% ##################
%  The algorithm was implemented by Daniel Leitold 

% add matlabBGL toolbox to generate shortest paths
if ~exist('all_shortest_paths', 'file')
   mfilepath=fileparts(which('degreeRel'));
   addpath([mfilepath,'\..\matlab_bgl']);
end
% determine the driver nodes
drivers=driverNodes(Bmatrix);
% determine the sensor nodes
sensors=sensorNodes(Cmatrix);
% generate shortest paths, then corrigate unreachable paths from Inf to 0
if issparse(Amatrix)
    sp=sparse(all_shortest_paths(Amatrix));
else
    sp=all_shortest_paths(sparse(Amatrix));
end
sp = sp(logical(sensors),logical(drivers));

% create r_i based on r_ij
sp = min(sp, [], 2);

% create r based on r_i
sp(sp == Inf) = 0;
relativeDegree = max(sp);

end

