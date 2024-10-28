function B = boundary_matrix_F2(simplices_k, simplices_k_minus_1)
    % Computes the boundary matrix B_d from d-simplices (simplices_k) to (d-1)-simplices (simplices_k_minus_1)
    % simplices_k: list of d-simplices
    % simplices_k_minus_1: list of (d-1)-simplices
    %
    % 4/10/24
    
    num_k_simplices = size(simplices_k, 1);  % Number of d-simplices -> columns
    num_k_minus_1_simplices = size(simplices_k_minus_1, 1);  % Number of (d-1)-simplices -> rows
    
    B = false(num_k_minus_1_simplices, num_k_simplices);  % Initialize boundary matrix as logical
    
    for i = 1:num_k_simplices % loop through columns
        simplex = simplices_k(i, :);
        for j = 1:length(simplex)
            face = simplex([1:j-1, j+1:end]);  % Remove one vertex to get a (d-1)-simplex
            face_idx = find_row(simplices_k_minus_1, face);  % Find index of the face in (d-1)-simplices
            if ~isempty(face_idx)
                B(face_idx, i) = true;  % Set boundary matrix entry to 1
            end
        end
    end
end