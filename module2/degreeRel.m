function [ relativeDegree ] = degreeRel( Amatrix, Bmatrix, Cmatrix )
%DEGREEREL function generates the relative degree of the given system
% determined by input A, B and C matrices of state-space model. The relative
% degree is the maximum of the lengths of all geodesic paths between each 
% driver node - sensor node pair. If there is no path between a driver node
% - sensor node pair, then the length of the path is zero. This measure can
% says that how many derives needed to appear the inputs on the outputs. 
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
%      4
% ##################
%  The algorithm was implemented by Daniel Leitold 

% add matlabBGL toolbox to generate shortest paths
mfilepath=fileparts(which('degreeRel'));
addpath(fullfile(mfilepath,'../matlab_bgl'));
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
sp(sp==Inf)=0;

% change paths to 0 which are not from an driver to a sensor
degrees=sp.*(sensors'*drivers);

% set up the output variable with the longest path's length
relativeDegree=max(max(degrees));

end

