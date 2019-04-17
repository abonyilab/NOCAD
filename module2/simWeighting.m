function [ weight ] = simWeighting( set1, set2 )
%SIMWEIGHTING generates a weighting for the similarity of two sets, where 
% the distance is defined. The two input sets: set1 and set2 is a row vector,
% where the i. element shows the distance of element i. If the distance is
% 0, then element i is not in the set. The weight multiplier is the sum
% of absolute difference of the same elements' distance, then this value is
% divided with the theoretical maximum. In the end the given value is 
% substract from one, so the high similarity cause a value near one, 
% while the different sets cause near zero value.
% ##################
% Example:
% ##################
% Inputs: 
%
% set1=[0 5 2 0 1 6 7];         % could be sparse
% set2=[2 0 0 4 6 0 0];         % could be sparse
% ##################
% Function Calling:
%
% weight=simWeighting(set1, set2)
% ##################
% Output:
%
% weight =
%     0.2857
% ##################
%  The algorithm was implemented by Daniel Leitold 

    common=find(set1&set2);
    maxDistance=max([set1, set2]);
    
    % if the intersection is empty, then the weight is zero
    if ~any(common)
        weight=0;
    else
        weight=0;
        for actual=common
            weight=weight+abs(set1(actual)-set2(actual));
        end

        weight=1-(weight/(maxDistance*length(common)));
    end
end

