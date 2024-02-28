function [pVal, tVal, Cohen_d] = perform_ttest2(FC1, FC2)
% perform_ttest2 Conducts a paired t-test on the third dimension of two 3D FC matrices.
%
%   INPUT:
%       FC1, FC2 - 3D matrices representing functional connectivity (FC) datasets.
%                  Size of the matrices: [M x M x P], where M is the number of regions,
%                  and P is the number of samples in each dataset.
%
%   OUTPUT:
%       pVal    - 2D matrix of size [M x M] containing p-values from the t-test.
%       tVal    - 2D matrix of size [M x M] containing t-values from the t-test.
%       Cohen_d - 2D matrix of size [M x M] containing effect size (Cohen's d) values.
%
% Note: This function assumes that the 'computeCohen_d' function is available.

    
    % Determine the number of regions (assuming square matrices in the first two dimensions)
    num_regions = length(FC1);
    
    % Initialize matrices for p-values, t-values, and effect sizes
    pVal = zeros(num_regions, num_regions);
    tVal = zeros(num_regions, num_regions);
    Cohen_d = zeros(num_regions, num_regions);

    % Iterate over each element in the first two dimensions of the FC matrices
    for i1 = 1:num_regions
        for i2 = 1:num_regions
            % Extract data for the current element from both FC matrices across the third dimension
            y1 = FC1(i1, i2, :);
            y1 = y1(:); % Convert y1 into a column vector
            y2 = FC2(i1, i2, :);
            y2 = y2(:); % Convert y2 into a column vector

            % Perform the paired t-test on y1 and y2
            [~, p, ~, stats] = ttest(y1, y2);
            
            % Store the p-value and t-value in the respective matrices
            pVal(i1, i2) = p;
            tVal(i1, i2) = stats.tstat;
            
            % Compute Cohen's d effect size and store it in the Cohen_d matrix
            Cohen_d(i1, i2) = computeCohen_d(y1(:), y2(:), 'paired');
        end
    end
end
