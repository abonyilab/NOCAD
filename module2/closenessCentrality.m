function [ closeness, inCloseness, outCloseness ] = closenessCentrality( adj )
%CLOSENESSCENTRALITY function generates the closeness centrality for
% directed graph given by adj. The function returns with the closeness, the
% incloseness, and out closeness, where the closeness is the sum of the n-
% and out closeness. The function uses the matlab BGL toolbox. 
% ##################
% Example:
% ##################
% Input: 
%
% adj=[0 0 0 0; 1 0 0 0; 0 1 0 0; 1 0 0 0];     % could be sparse
% ##################
% Function Calling:
%
% [closeness, inCloseness, outCloseness]=closenessCentrality(adj)
% ##################
% Outputs:
%
% closeness = 
%     2.2500    2.0000    1.3333    1.0000
% 
% inCloseness =
%     2.2500    1.0000         0         0
% 
% outCloseness =
%          0    1.0000    1.3333    1.0000
% ##################
%  The algorithm was implemented by Daniel Leitold 


   mfilepath=fileparts(which('closenessCentrality'));
   addpath(fullfile(mfilepath,'../matlab_bgl'));
   
   if issparse(adj) 
      paths=all_shortest_paths(adj);
   else
      paths=all_shortest_paths(sparse(adj));
   end
   paths(paths==Inf)=0;
   
   inNumOfReachable=sum(paths~=0,1);
   outNumOfReachable=sum(paths~=0,2)';
   inFareness=sum(paths,1);
   outFareness=sum(paths,2)';

   
   inCloseness=(inNumOfReachable.^2)./inFareness;
   inCloseness(isnan(inCloseness))=0;
   outCloseness=(outNumOfReachable.^2)./outFareness;
   outCloseness(isnan(outCloseness))=0;
   closeness=inCloseness+outCloseness;

end

