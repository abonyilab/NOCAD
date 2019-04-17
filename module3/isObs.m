function [isObserv] = isObs(adj, sensors)
%ISOBS determines if the system describe by its adjacency matrix A (not
% state-transition matrix)is structurally observable by sensors.
% ##################
% Example:
% ##################
% Inputs:
%
% adj = [0 1 0 0; 0 0 1 0; 1 0 0 1; 0 0 0 0];
% sensors = 4;
% ##################
% Function Calling:
% 
% [isObserv] = isObs(adj, sensors);
% ##################
% Output:
%
% isObserv =
%      1
% ##################
%  The algorithm was implemented by Daniel Leitold 

if ~exist('isObservable', 'file')
   mfilepath=fileparts(which('isObs'));
   addpath(genpath([mfilepath,'\..\module2']));
end

% Create C matrix
Cmat = zeros(length(sensors), size(adj,1));
for id = 1:length(sensors)
    Cmat(id, sensors(id)) = 1;
end

isObserv = isObservable(adj', Cmat);
end