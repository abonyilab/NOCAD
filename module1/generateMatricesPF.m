function [ Amatrix, Bmatrix, Cmatrix, Dmatrix ] = generateMatricesPF( adj )
%GENERATEMATRICESPF generates B and C matrices of state-space model
% from A matrix. To generate matrices generateMatricesPF uses the
% maximumMatchingPF algorithm, so the unmatched SCCs will be 
% resolved by path finding.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[0 1 0 0; 0 0 1 0; 1 0 0 1; 0 0 0 0];     % could be sparse
% ##################
% Function Calling:
%
% [Amatrix, Bmatrix, Cmatrix, Dmatrix]=generateMatricesPF(adj)
% ##################
% Outputs:
%
% Amatrix =
%      0     0     1     0
%      1     0     0     0
%      0     1     0     0
%      0     0     1     0
% 
% Bmatrix =
%      1
%      0
%      0
%      0
% 
% Cmatrix =
%      0     0     0     1
% 
% Dmatrix =
%      0
% ##################
%  The algorithm was implemented by Daniel Leitold 

% Observe
% generate sensor nodes
% execute maximum matching with path finding
Amatrix=adj';
[~, unmatched, ~]=maximumMatchingPF(Amatrix);

% set sensor nodes
sensorNodes=unmatched;

% define C matrix
Cmatrix=sparse(1:length(sensorNodes), sensorNodes, 1,...
    length(sensorNodes), length(Amatrix));


% Control
% generate driver nodes
% transpose the A matrix
% execute maximum matching with path finding
[~, unmatched, ~]=maximumMatchingPF(Amatrix');

% set driver nodes
driverNodes=unmatched;

% define B matrix
Bmatrix=sparse(driverNodes, 1:length(driverNodes), 1,...
    length(Amatrix), length(driverNodes));

% define D matrix
Dmatrix=sparse([],[],1,length(sensorNodes), length(driverNodes));
if ~issparse(adj)
    Bmatrix=full(Bmatrix);
    Cmatrix=full(Cmatrix);
    Dmatrix=full(Dmatrix);
end

end