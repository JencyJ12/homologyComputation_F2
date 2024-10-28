% homologyComp Package for computing simplicial homology groups as well as 
% persistent homology over F2.
%
%   buildSimplices - construct a cell of simplices given an array of
%   binary codes where each row represents a simplex, e.g. [0 1 0 1]
%   represents the simplex [2,4], where vertices are labeled 1 through 4
%   
%   boundary_matrix_F2 - compute the i-th boundary map represented in matrix
%   form
% 
%   homology_F2 - compute the homology group of a given simplicial complex
%   over F2
%
%   buildFiltration - produce an array for a sequence of simplicial 
%   complexes given a sequence of values corresponding to each simplex 
%   
%   computeBettiCurve_F2 - produce an array of Betti curves based on
%   filtration, we assume that the filtration start with all the possible
%   vertices present
%
% Can call a function by doing homologyComp.function
%
% Use help homologyComp to see documentation for specific functions
%