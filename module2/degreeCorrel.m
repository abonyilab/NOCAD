function [ in_in, in_out, out_out, out_in ] = degreeCorrel( adj )
%DEGREECORREL function calculates the degree correlation for each node in
% the network described by input adj, which is directed. The correlation is
% calculated the average degree of a node's neighbors. For example the in-out
% correlation of node i is means the average outdegree of the nodes, which 
% are the other end of node i input edges. Based on these raw data, the
% degree correlation could be evaulated.
% ##################
% Example:
% ##################
% Inputs: the input could be sparse
%
% adj=[
% 0 1 0 0 0 1;
% 0 0 0 0 0 0;
% 1 1 0 1 0 1;
% 1 0 0 0 0 0;
% 0 0 1 1 0 0;
% 0 0 0 0 1 0];
% ##################
% Function Calling:
%
% [in_in, in_out, out_out, out_in]=degreeCorrel(adj)
% ##################
% Outputs:
%
% in_in =
%     1.5000    1.5000    1.0000    1.0000    2.0000    1.5000
% 
% in_out =
%     2.5000    3.0000    2.0000    3.0000    1.0000    3.0000
% 
% out_out =
%     0.5000         0    1.0000    2.0000    2.5000    2.0000
% 
% out_in =
%     2.0000         0    2.0000    2.0000    1.5000    1.0000
% ##################
%  The algorithm was implemented by Daniel Leitold 

    inDeg=degreeIn(adj);
    outDeg=degreeOut(adj);
    inNotNull=inDeg~=0;
    outNotNull=outDeg~=0;
    adj=+adj~=0;
    
    in_in=inDeg*adj;
    in_in(inNotNull)=in_in(inNotNull)./inDeg(inNotNull);
    
    in_out=outDeg*adj;
    in_out(inNotNull)=in_out(inNotNull)./inDeg(inNotNull);
    
    out_out=outDeg*adj';
    out_out(outNotNull)=out_out(outNotNull)./outDeg(outNotNull);
    
    out_in=inDeg*adj';
    out_in(outNotNull)=out_in(outNotNull)./outDeg(outNotNull);

end

