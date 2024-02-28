function plot_Cohens_d_subset(input_matrix, labels, title_, row_range, col_range,x_label,y_label)
% plot_Cohens_d_subset Visualizes a subset of the matrix of Cohen's d values.
%
%   INPUT:
%       input_matrix - The full matrix from which a subset will be extracted and plotted.
%       labels       - The labels corresponding to the rows/columns of the matrix.
%       title_       - The title to be displayed above the plot.
%       row_range    - The range of rows to extract for the subset.
%       col_range    - The range of columns to extract for the subset.
%       x_label      - The label for the x-axis.
%       y_label      - The label for the y-axis.

    % Get the min and max values of the entire matrix to maintain color scale consistency.
    original_limits = [min(input_matrix(:)), max(input_matrix(:))];

    topMargin = 0.2; % Define top margin for plot positioning.
    
    % Create the figure with desired properties
    fig = figure('Position', [10, 50, 1300, 700]);
    
    % Calculate the new position of the axes
    axesPosition = [0.12, topMargin, 0.8, 0.92 - topMargin];
    
    % Create the axes within the figure with adjusted position
    ax = axes('Parent', fig, 'Position', axesPosition);
    
    % Extract the subset of the input_matrix based on row and column ranges
    subset_matrix = input_matrix(row_range, col_range);
    
    % Plot the subset, keeping the color limits consistent with the full matrix.
    fig=imagesc(ax, subset_matrix, original_limits);

    [rows, cols] = size(subset_matrix); % Get the size of the subset matrix.
    spacex = 1;
    spacey = 1;
    
    set(fig, 'AlphaData', ~isnan(subset_matrix));

    % Set the x-axis labels and ticks
    set(gca, 'XTickLabel', strrep(labels(col_range(1):spacex:col_range(end)), '_', ' '), 'XTick', 1:spacex:cols);
    rotateticklabel(gca, 'x', 90, 10, 0);

    % Set the y-axis labels and ticks
    set(gca, 'YTickLabel', strrep(labels(row_range(1):spacey:row_range(end)), '_', ' '), 'YTick', 1:spacey:rows);
    
    Xtick_pos = 1.5:cols;
    Ytick_pos = 1.5:rows;
    
    xline(Xtick_pos, '-', 'Color', [0.5 0.5 0.5]);
    yline(Ytick_pos, '-', 'Color', [0.5 0.5 0.5]);
    rotateticklabel(gca, 'y', 0, 10, 0);

    % Draw lines indicating boundaries of specific cortical divisions
    Region_Index=[1 4 10 17 26 31 40 47 52 59 67 79 87 95 100 110 120 133 149 158 167];
    xline(Region_Index+1.5-col_range(1),'-k','LineWidth',2);
    yline(Region_Index+1.5-row_range(1),'-k','LineWidth',2);
    
    % Add a colorbar to the figure
    cb = colorbar;
    cb.Label.String = 'Cohen''s d';  % Label for the colorbar
    % Use the 'jet' colormap
    colormap('jet');

    % Set the title of the plot
    title(title_)

    % Set x-label and y-label positions
    xlabel(x_label, 'Position', [cols/2+0.5, 1.2*rows+0.5]);
    ylabel(y_label, 'Position', [-0.6*cols, rows/2+0.5]);
    %ylabel(y_label, 'Position', [-1.2, rows/2+0.5]);

end
