function resultTable = extract_top_significant_d(Cohens_d, rejection_matrix, pValue_matrix, labels, division_names, h)
%   extract_top_significant_d Extracts the top h significant Cohen's d values from the upper triangle 
%   of a matrix based on a rejection matrix and returns them in a table format.
%   Additonally, it counts and displays the number of significant Cohen's d
%   values exceeding 0.5, 0.8, 1.2 and 2
%
%   INPUT:
%       Cohens_d         - A matrix containing Cohen's d values.
%       rejection_matrix - A matrix indicating whether each Cohen's d value is significant (1 for significant, 0 otherwise).
%       pValue_matrix    - A matrix containing p-values corresponding to each Cohen's d value.
%       labels           - A cell array of cortical region names corresponding to the rows and columns of the matrices.
%       division_names   - A cell array of cortical division names corresponding to the rows and columns of the matrices.
%       h                - An integer indicating the number of top values to extract.
%
%   OUTPUT:
%       resultTable - A table containing the top h significant Cohen's d values, their p-values, 
%           and the corresponding labels and division names.

    % Extract only the significant Cohen's d values from the upper triangle
    [rows, cols] = find(triu(rejection_matrix));
    significant_Cohens_d = Cohens_d(sub2ind(size(Cohens_d), rows, cols));
    corresponding_pValues = pValue_matrix(sub2ind(size(pValue_matrix), rows, cols));

    % Sort by Cohen's d in descending order
    [sorted_Cohens_d, sorted_indices] = sort(significant_Cohens_d, 'descend');
    sorted_pValues = corresponding_pValues(sorted_indices);
    sorted_rows = rows(sorted_indices);
    sorted_cols = cols(sorted_indices);

    % Extract the top h values
    top_count = min(h, length(sorted_Cohens_d));
    top_Cohens_d = sorted_Cohens_d(1:top_count);
    top_pValues = sorted_pValues(1:top_count);
    row_labels = labels(sorted_rows(1:top_count));
    col_labels = labels(sorted_cols(1:top_count));
    row_divisions = division_names(sorted_rows(1:top_count));
    col_divisions = division_names(sorted_cols(1:top_count));

    % Create a table
    resultTable = table(row_labels, row_divisions, col_labels, col_divisions, top_Cohens_d, top_pValues, ...
                        'VariableNames', {'Row_Label', 'Division_Name_row','Column_Label', 'Division_Name_col','Cohens_d', 'p_value'});

    % Count the number of Cohen's d values exceeding 0.5
    num_large_Cohens_d = sum(sorted_Cohens_d > 0.5);
    disp(['Number of Cohen''s d values exceeding 0.5: ' num2str(num_large_Cohens_d)]);

    % Count the number of Cohen's d values exceeding 0.8
    num_large_Cohens_d = sum(sorted_Cohens_d > 0.8);
    disp(['Number of Cohen''s d values exceeding 0.8: ' num2str(num_large_Cohens_d)]);

    % Count the number of Cohen's d values exceeding 1.2
    num_large_Cohens_d = sum(sorted_Cohens_d > 1.2);
    disp(['Number of Cohen''s d values exceeding 1.2: ' num2str(num_large_Cohens_d)]);

    % Count the number of Cohen's d values exceeding 2
    num_large_Cohens_d = sum(sorted_Cohens_d > 2);
    disp(['Number of Cohen''s d values exceeding 2: ' num2str(num_large_Cohens_d)]);

end
