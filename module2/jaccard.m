function [ jaccard_similarity ] = jaccard( set1, set2 )
%JACCARD function generates the similarity of two set according to
% Jaccard's article from 1901. The input sets are two binary vector, where
% the i.th element is 1 if it is in the set, otherwise 0. The function
% returns with the similarity, i.e. the section of the two sets divided by
% the union of them. 
% ##################
% Example:
% ##################
% Inputs: 
%
% set1=[0 1 1 0 0 1];       % could be sparse
% set2=[1 0 1 0 0 1];       % could be sparse
% ##################
% Function Calling:
%
% jaccard_similarity=jaccard(set1, set2)
% ##################
% Output:
%
% jaccard_similarity = 
%     0.5000
% ##################
%  The algorithm was implemented by Daniel Leitold 

    % union of the sets
    uni=set1|set2;
    % section of the sets
    inter=set1&set2;
    
    % if both sets are empty, then the similarity is zero
    if ~any(uni)
        jaccard_similarity=0;
    else
        jaccard_similarity=sum(inter)/sum(uni);
    end

end

