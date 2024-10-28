function idx = find_row(matrix, row)
    % Finds the index of the row in the matrix
    idx = find(ismember(matrix, row, 'rows'));
end
