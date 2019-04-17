function [ sS ] = sumSq( x,y )
%SS function calculates sum of squares. The sum of squares could be used on
% a set of n values, or two sets of n values.
% #1: SS(x)=sum(x^2)-((sum(x)^2)/n)
% #2: SS(xy)=sum(x*y)-((sum(x)*sum(y))/n)
% This function has two input parameter, so to calculate the first type of
% the sum of squares, both input parameter is 'x'.
% The vector x and y must be same size
% ##################
% Example:
% ##################
% Input: 
%
% x=[1 2 3 4 5];     % could be sparse
% y=[5 4 3 2 1];     % could be sparse
% ##################
% Function Calling:
%
% sS1=sumSq(x,y)
% sS2=sumSq(x,x)
% ##################
% Output:
%
% sS1 =
%    -10
% 
% sS2 =
%     10
% ##################
%  The algorithm was implemented by Daniel Leitold 

if(iscolumn(x))
    x=x';
end
if(iscolumn(y))
    y=y';
end
n=length(x);
sS=(x*y')-((sum(x)*sum(y))/(n));
end

