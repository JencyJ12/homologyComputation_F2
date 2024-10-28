function bettiSeq = computeBettiCurve_F2(filtration,incVert)
% this function computes sequence of Betti numbers given a filtration of
% simplicial complexes (over F2)
% incVert should be a boolean, where if true, then order of adding in
% vertices is included in filtration, i.e. vertices not added in
% immediately before edges are added in
%
% written 11/10/24 by JJ
%
% edit 18/10/24 to include the option where vertices are not added in first

% highest dimension simplex
n_dim = sum(filtration(end,:));
[n_step,n_nodes] = size(filtration); 

bettiSeq = zeros(1,n_dim);

if incVert
    bettiSeq(1) = 1;
    for i = 2:n_step
        seqSimp = filtration(1:i,:);
        % display(seqSimp)
        simplices = buildSimplices(seqSimp);
        display(['step', int2str(i)]);
        betti_i = homology_F2(simplices);
        temp = zeros(1,n_dim);
        temp(1:length(betti_i)) = betti_i;
        bettiSeq = [bettiSeq; temp];
    end
else
    bettiSeq(1) = n_nodes; % start with n_nodes disconnected components
    simp_0 = nkCycle(n_nodes,1); 
    filtration = [simp_0;filtration]; % add in 0-simplices
    for i = 1:n_step
        seqSimp = filtration(1:n_nodes+i,:);
        % display(seqSimp)
        simplices = buildSimplices(seqSimp);
        display(['step', int2str(i+1)]);
        betti_i = homology_F2(simplices);
        temp = zeros(1,n_dim);
        temp(1:length(betti_i)) = betti_i;
        bettiSeq = [bettiSeq; temp];
    end
end
% display(filtration)

end