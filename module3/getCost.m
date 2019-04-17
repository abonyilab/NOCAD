function [ cost, maxDeg, meanDeg ] = getCost(nodes, alpha, dists )
%GETCOST qualifies the input(or output) configuration. It generates
% relative degree as calculate the distance -dists- between driver 
% (or sensor) -nodes- and all state variables. The cost function is
% alpha*maxDeg + (1-alpha)*meanDeg, where maxDeg is the relative degrees,
% i.e. the maximum of relative degree, while meanDeg is the mean of
% relative degrees.
% For more information: Sensors, 18(9), 3096.
% ##################
% Example:
% ##################
% Inputs: 
%
% % A = [0 1 0 0; 0 0 1 0; 1 0 0 1; 0 0 0 0];
% nodes = [1 3];
% alpha = 0.5;
% dists = [0 1 2 3; 2 0 1 2; 1 2 0 1; Inf Inf Inf 0];
% ##################
% Function Calling:
% 
% [ cost, maxDeg, meanDeg ] = getCost(nodes, alpha, dists );
% ##################
% Output:
%
% cost =
%     0.7500
% 
% maxDeg =
%      1
% 
% meanDeg =
%     0.5000
% ##################
%  The algorithm was implemented by Daniel Leitold 

    degrees = min(dists(nodes, :), [], 1);
    maxDeg = max(degrees);
    meanDeg = mean(degrees);
    cost = alpha*maxDeg + (1-alpha)*meanDeg;
end

