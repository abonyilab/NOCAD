function [isContr] = isCont(adj, drivers)
%ISCONT determines if the system describe by its adjacency matrix A (not
% state-transition matrix)is structurally controllable by drivers.
% ##################
% Example:
% ##################
% Inputs: all matrix could be sparse
%
% adj = [0 1 0 0; 0 0 1 0; 1 0 0 1; 0 0 0 0];
% drivers = 1;
% ##################
% Function Calling:
% 
% isContr = isCont(adj, drivers);
% ##################
% Output:
%
% isContr =
%      1
% ##################
%  The algorithm was implemented by Daniel Leitold 

if ~exist('isControllable', 'file')
   mfilepath=fileparts(which('isCont'));
   addpath(genpath([mfilepath,'\..\module2']));
end

% Create B matrix
Bmat = zeros(size(adj,1), length(drivers));
for id = 1:length(drivers)
    Bmat(drivers(id), id) = 1;
end

isContr = isControllable(adj', Bmat);
end