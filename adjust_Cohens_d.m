function Cohen_d_adj = adjust_Cohens_d(Cohen_d, rejection_region, percentile)
% adjust_Cohens_d Adjusts Cohen's d values based on rejection region and percentile criteria.
%
%   INPUT:
%       Cohen_d          - Matrix of original Cohen's d values.
%       rejection_region - Matrix containing the rejectiion regions.
%       percentile       - Percentile value to define the adjustment criteria.
%
%   OUTPUT:
%       Cohen_d_adj - Adjusted Cohen's d matrix.

    % Determine the number of brain regions investigated 
    NumRegion = size(rejection_region, 1); 

    % Initialize adjusted Cohen's d matrix to original values
    Cohen_d_adj = Cohen_d;

    % Reshape the Cohen's d matrix into a column vector
    Cohen_d_flat = reshape(Cohen_d, [], 1);

    % Calculate the lower and upper percentiles
    percentile_low = prctile(Cohen_d_flat, percentile);
    percentile_high = prctile(Cohen_d_flat, 100 - percentile);

    % Loop through each cell of the right-upper half of the Cohen's d matrix
    for i1 = 1:NumRegion
        for i2 = i1:NumRegion
            % Set values to NaN if they are outside the accepted percentile range
            if Cohen_d_adj(i1, i2) > percentile_low && Cohen_d_adj(i1, i2) < percentile_high
                Cohen_d_adj(i1, i2) = NaN;
            end

            % Set values to NaN if they are rejected based on the rejection matrix
            if rejection_region(i1, i2) == 0
                Cohen_d_adj(i1, i2) = NaN;
            end
        end
    end
end
