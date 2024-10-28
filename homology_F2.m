function betti_str = homology_F2(simplices)
    % This function computes the simplicial homology groups H_0, H_1, ... over F2
    % Input: simplices, a cell array where simplices{d+1} contains d-simplices, i.e.
    % simplices{1} = vertices (0-simplices)
    % simplices{2} = edges (1-simplices)
    % simplices{3} = triangles (2-simplices)
    % ...
    % Output: betti_str, an array containing Betti number for homology groups
    %           over F2
    % 
    % created 4/10/24
    %
    
    n_dim = length(simplices); 
    n_vert = length(simplices{1});
    % obtain rank and nullity of each boundary map
    bndDim = [n_vert,0];

    for i = 2:(n_dim)
        bndMatrix = boundary_matrix_F2(simplices{i},simplices{i-1}); % (i-1)-dimensional boundary morphism
        [rrefMatrix,pivots] = rref_F2(bndMatrix);
        [nullity, rank] = bndRankNul(rrefMatrix,pivots);
        bndDim = [bndDim; [nullity, rank]];
    end
    
  
    betti_str = [];
    % Loop through dimensions and compute homology groups H_k
    for i = 1:(n_dim-1)
        % H_k = ker(d_{k})/im(d_{k+1}) 
        % Betti_k = nullity(d_{k})-rank(d_{k+1})

        dim_str = strcat("dim ", num2str(i-1));
        
        betti_i_minus_1 = bndDim(i,1) - bndDim(i+1,2);
        display(['Dimension of H_', num2str(i-1),':',num2str(betti_i_minus_1)]);
        betti_str = [betti_str, betti_i_minus_1];
    end
    
    dim_str = strcat("dim ", num2str(n_dim-1));
        
    betti_n_dim_minus_1 = bndDim(n_dim,1);
    display(['Dimension of H_', num2str(n_dim-1),':',num2str(betti_n_dim_minus_1)]);
    betti_str = [betti_str, betti_n_dim_minus_1];

    % compute (length(simplices)-1)-dim homology
end






