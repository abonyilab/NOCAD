function [ Amatrix, Bmatrix, Cmatrix, Dmatrix ] = generateMatricesSS( adj )
%GENERATEMATRICESSS generates B and C matrices of state-space model
% from A matrix. To generate matrices generateMatricesSS uses the
% maximumMatchingSS algorithm, so the uncontrolled SCCs will be 
% resolved by signal sharing.
% ##################
% Example:
% ##################
% Input: 
%
% adj=[0 1 0 0; 0 0 1 0; 1 0 0 1; 0 0 0 0];     % could be sparse
% ##################
% Function Calling:
%
% [Amatrix, Bmatrix, Cmatrix, Dmatrix]=generateMatricesSS(adj)
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
%      1
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
% execute maximum matching signal sharing
Amatrix=adj';
[~, unmatched, unmatchedSCC, ~]=maximumMatchingSS(Amatrix);

% set sensor nodes
sensorNodes=unmatched;

% define C matrix
Cmatrix=sparse(1:length(sensorNodes), sensorNodes, 1,...
    length(sensorNodes), length(Amatrix));

% correct Cmatrix according to SCC (divide signal)
Cmatrix(1,unmatchedSCC)=1;
    


% Control
% generate driver nodes
% transpose the A matrix
% execute maximum matching with signal sharing
[~, unmatched, unmatchedSCC, ~]=maximumMatchingSS(Amatrix');

% set driver nodes
driverNodes=unmatched;

% define B matrix
Bmatrix=sparse(driverNodes, 1:length(driverNodes), 1,...
    length(Amatrix), length(driverNodes));

% correct Bmatrix according to SCC (divide signal)
Bmatrix(unmatchedSCC,1)=1;

% define D matrix
Dmatrix=sparse([],[],1,length(sensorNodes), length(driverNodes));
if ~issparse(adj)
    Bmatrix=full(Bmatrix);
    Cmatrix=full(Cmatrix);
    Dmatrix=full(Dmatrix);
end

end

