% Function file: calculate the temperature field for each time step
% Input: T - temperature field, h - grid spacing, nx and ny - grid points
% Output: TT - second-order derivative approximation

function [TT] = Laplacian(T, h, nx, ny)
    TT = T;
    % Note: not change the values of all boundary points 
    for i = 2 : ny -1           % row: y = 50
        for j = 2 : nx - 1      % column: x = 100
            TT(i,j) = (T(i-1, j) + T(i+1, j) + T(i, j-1) + T(i, j+1) - 4*T(i, j)) / h^2;
        end
    end
end
