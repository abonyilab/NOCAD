%  The algorithm was implemented by Daniel Leitold 

% ######### NETWORK THEORY #########
% Take an arbitrary input network
adj=[0 1 0 0; 0 0 1 0; 1 0 0 1; 0 0 0 0];
% The network could be sparse, the the state space model's matrices will be
% sparse as well

% MAXIMUMMATCHING
% It returns the matched nodes, the unmatched nodes and the pairing,
% where the i. node matched by matchedBy(i) based on the combinatorical
% maximum matching algorithm.
[matched, unmatched, matchedBy]=maximumMatching(adj);

% MAXIMUMMATCHINGSS
% It returns the matched nodes, the unmatched nodes, the unmatchedSCC
% vector, which contain that nodes, which is member of an unmatched
% SCC, and the fourth output is the pairing, where the i. node matched 
% by matchedBy(i) based on the combinatorical maximum matching algorithm.
[matched, unmatched, unmatchedSCC, matchedBy]=maximumMatchingSS(adj);

% MAXIMUMMATCHINGPF
% It returns the matched nodes, the unmatched nodes and the pairing,
% where the i. node matched by matchedBy(i) based on the combinatorical
% maximum matching algorithm. In addition, the unmatched SCCs are
% resolved by path finding. 
[matched, unmatched, matchedBy]=maximumMatchingPF(adj);

% ######### SYSTEM THEORY ########
% GENERATEMATRICESSS
% generateMatricesWithSCC generates the B and C matrices such that, the
% unmatched SCCs resolved by signal sharing, i.e. it uses the
% maximumMatchingSS.
[Amatrix, Bmatrix, Cmatrix, Dmatrix]=generateMatricesSS(adj);

% GENERATEMATRICESPF
% generateMatricesWithPath generates the B and C matrices such that, the
% unmatched SCCs resolved by path finding, i.e. it uses the
% maximumMatchingPF.
[Amatrix, Bmatrix, Cmatrix, Dmatrix]=generateMatricesPF(adj);