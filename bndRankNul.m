function [nullity, rank] = bndRankNul(A,pivots)
% compute the rank and nullity of A assuming that A = rref(A) over F2 and
% pivots is the pivot columns of A
%
% created 4/10/24 
%

[~,ncol] = size(A);
rank = length(pivots);

% rank-nullity theorem
nullity = ncol-rank;

end