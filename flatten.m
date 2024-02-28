function flat_FC = flatten(FC)
% flatten Flattens the upper triangular part of a 3D matrix into a 2D matrix
% INPUT:
%   FC: A 3D matrix where the third dimension represents different subjects
%         and the first two dimensions represent some kind of connectivity matrix 
%         (e.g., functional connectivity).
%
% OUTPUT:
%   flat_FC: A 2D matrix where each row corresponds to a subject and each column
%              corresponds to an entry from the upper triangular part of the original
%              3D matrix.

    % Get the number of rows (regions) in the connectivity matrix.
    rows = size(FC, 1);
    
    % Get the total number of subjects.
    subjects = size(FC, 3);
    
    % Calculate the number of unique elements in the upper triangular part.
    new_size = (rows - 1) * rows / 2;
    
    % Initialize the flattened matrix.
    flat_FC = zeros(subjects, new_size);
    
    % Loop through each subject to flatten their FC matrix.
    for i1 = 1:subjects
        
        mat_entry = 0;
        
        % Loop through rows of the matrix.
        for i2 = 1:rows
            
            % Loop through the columns for upper triangular extraction.
            for i3 = (i2+1):rows
                
                mat_entry = mat_entry + 1;
                
                % Assign the upper triangular values to the flattened matrix.
                flat_FC(i1, mat_entry) = FC(i2, i3, i1);
            end
        end
    end
end
