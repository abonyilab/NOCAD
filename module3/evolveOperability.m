function [actCovSet, actCovRetSet, senCovSet, senCovRetSet, actNetMesRetSet, senNetMesRetSet] = evolveOperability ( A, maxRelDeg )
%EVOLVEOPERABILITY generates driver and sensor node sets for a system
% described by its adjacency matrix A (not state-transition matrix) such
% that the resulted system have relative degree smaller then maxRelDeg.
% ##################
% Example:
% ##################
% Inputs:
%
% A = [0 1 0 0; 0 0 1 0; 1 0 0 1; 0 0 0 0];
% maxRelDeg = 2;
% ##################
% Function Calling:
% 
% [actCovSet, actCovRetSet, senCovSet, senCovRetSet, actNetMesRetSet, ...
%     senNetMesRetSet] = evolveOperability ( A, maxRelDeg )
% ##################
% Output:
%
% actCovSet =
%      3
% 
% actCovRetSet =
%      1     3
% 
% senCovSet =
%      2
% 
% senCovRetSet =
%      1     4
% 
% actNetMesRetSet =
%      1
%      3
% 
% senNetMesRetSet =
%      3
%      4
% ##################
%  The algorithm was implemented by Daniel Leitold 

if ~exist('generateMatricesPF', 'file')
  mfilepath=fileparts(which('evolveOperability'));
  addpath(genpath([mfilepath,'\..\module1']));
end

if issparse(A)
    A = full(A);
end

% Set-cover grassroot design - controllabilit/observability are not guaranteed
[actCovSet, ~] = setCover(A, maxRelDeg);
[senCovSet, ~] = setCover(A', maxRelDeg);

% Design minimum configurations
[~,Bm,Cm,~] = generateMatricesPF(A);
% Driver nodes 
drivers = find(sum(Bm,2)~=0)';
% Sensor nodes
sensors = find(sum(Cm, 1)~=0);

% Network measures retrofit design
actNetMesRetSet = analyseComponents(A, drivers, maxRelDeg);
senNetMesRetSet = analyseComponents(A', sensors, maxRelDeg);

% Set cover retrofit design
[actCovRetSet, ~] = setCoverExcept(A, maxRelDeg, drivers);
[senCovRetSet, ~] = setCoverExcept(A', maxRelDeg, sensors);

end
