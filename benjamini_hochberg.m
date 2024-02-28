function rejection = benjamini_hochberg(pVal, q)
% benjamini_hochberg Implements the Benjamini-Hochberg procedure to control the false discovery rate.
%
%   INPUT:
%       pVal     - Matrix of p-values (n x m) where n is the number of tests and m is the number of hypotheses.
%       q        - Desired FDR level.
%
%   OUTPUT:
%       rejection - Binary matrix (same size as p_values) indicating which hypotheses are rejected. Elements are 1 for rejected 
%                   hypotheses and 0 otherwise.

    % Vectorize the p-values and sort them in ascending order.
    p_values_vec = pVal(:);
    [~, sorted_idx] = sort(p_values_vec);

    % Calculate the adjusted p-values (BH-adjusted p-values).
    m = numel(p_values_vec);
    adjusted_p_values = (1:m) * q / m;

    % Find the largest index k where p(k) <= k/m * q
    k_max = 0;
    for k = 1:m
        if p_values_vec(sorted_idx(k)) > k / m * q
            break;
        end
        k_max = k;
    end

    % Set the adjusted p-values greater than k/m * q to k/m * q.
    if k_max > 0
        adjusted_p_values(k_max + 1:end) = min(adjusted_p_values(k_max + 1:end), k_max / m * q);
    end

    % Reshape the adjusted p-values back to the original matrix size.
    adjusted_p_values = reshape(adjusted_p_values, size(pVal));

    % Determine which hypotheses are rejected based on the adjusted p-values.
    rejection = pVal <= adjusted_p_values;

end
