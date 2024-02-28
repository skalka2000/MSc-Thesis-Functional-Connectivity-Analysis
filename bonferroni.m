function rejection = bonferroni(pVal, alpha)
% bonferroni Corrects p-values using the Bonferroni correction method for multiple comparisons.
%
%   INPUT:
%       pVal   - A 2D matrix of p-values, of size [M x M] where M is the number of brain regions.
%       alpha  - Desired significance level.
%
%   OUTPUT:
%       rejection - A 2D binary matrix (same size as pVal). Elements are 1 where the p-value is significant after correction,
%                   and 0 otherwise.
%
% Note: This function assumes symmetric p-values, i.e., p-value between region A and region B is the same as that between B and A.

    % Determine the number of brain regions based on the size of the pVal matrix
    [NumRegion, ~] = size(pVal);

    % Calculate the number of unique comparisons being made
    % Since the matrix is symmetric, only half (excluding diagonal) is considered
    NumLink = NumRegion * (NumRegion - 1) / 2;

    % Set the threshold for Bonferroni correction
    Bon_threshold = alpha / NumLink;

    % Create a binary matrix indicating where p-values are below the corrected threshold
    rejection = pVal < Bon_threshold;
end
