function mean_FC = calculate_mean_FC(FC)
% calculate_mean_FC Computes the mean functional connectivity over the third dimension of the input matrix.
%
%   INPUT:
%       FC - A 3D matrix of size [M x N x P] where M and N represent rows and columns of the FC matrix 
%            and P represents the number of samples.
%
%   OUTPUT:
%       mean_FC - A 2D matrix of size [M x N] containing the mean FC values computed over the third dimension of the input matrix.

    % Get the size of the first and second dimensions of the FC matrix
    rows = size(FC, 1);
    columns = size(FC, 2);

    % Initialize the mean_FC matrix with zeros
    mean_FC = zeros(rows, columns);

    % Iterate over each element in the first two dimensions of the FC matrix
    for i1 = 1:rows
        for i2 = 1:columns
            % Extract the data across the third dimension for the current element
            y = FC(i1, i2, :);
            y = y(:); % Convert y into a column vector
            
            % Compute the mean over the third dimension and store in the mean_FC matrix
            mean_FC(i1, i2) = mean(y);
        end
    end
end
