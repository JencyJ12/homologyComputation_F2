function [R, pivots] = rref_F2(A)
    % Perform row reduction on A over F2, optimized using logical operations.
    [m, n] = size(A);
    pivots = [];  % List of pivot columns
    row = 1;  % Pointer to current row
    
    for col = 1:n
        % Find a pivot (non-zero) row in the current column
        pivot_row = find(A(row:end, col), 1) + row - 1;
        % display(pivot_row);
        if isempty(pivot_row)
            continue;  % No pivot in this column, move to next column
        end
        
        % Swap row
        A([row, pivot_row], :) = A([pivot_row, row], :);
        pivots = [pivots, col];  % Record pivot column
        
        % Eliminate all other rows in this column
        for i = [1:row-1, row+1:m]
            if A(i, col)
                A(i, :) = xor(A(i, :), A(row, :));  % XOR operation for binary addition
            end
        end
        
        row = row + 1;  % Move to the next row
        if row > m
            break;
        end
    end
    
    R = A;  % Row-reduced echelon form
end
