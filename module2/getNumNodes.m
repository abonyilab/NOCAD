function [ nDriver, nSensor ] = getNumNodes(A)
%GETNODES returns the number of driver and sensor nodes necessary for
% system described by input A to be controllable and observable. The
% function uses the path finding method to determine driver and sensor
% nodes.
% ##################
% Example:
% ##################
% Input: 
%
% A=[0 0 0; 1 0 0; 1 0 0];        % could be sparse
% ##################
% Function Calling:
%
% [nDriver,nSensor] = getNumNodes(A)
% ##################
% Output:
%
% nDriver =
%      2
% 
% nSensor =
%      2
% ##################
%  The algorithm was implemented by Daniel Leitold 

% add functions of module 1
if ~exist('maximumMatchingPF', 'file')
   mfilepath=fileparts(which('getNodes'));
   addpath(genpath([mfilepath,'\..\module1']));
end

% determine the driver nodes and its cardinality
[~,unmatched,~,~] = maximumMatchingPF(A');   % A' is adj
nDriver = length(unmatched);    
% determine the sensor nodes and its cardinality
[~,unmatched,~,~] = maximumMatchingPF(A);  % A is adj'
nSensor = length(unmatched);

end

