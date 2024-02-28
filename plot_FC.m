function plot_FC(input_matrix, labels, title_, scale_)
%plot_FC Visualizes the functional connectivity matrix
%
%   INPUTS:
%       input_matrix - NxN matrix representing functional connectivity.
%       labels       - Cell array containing labels for the matrix rows/columns.
%       title_       - String for the title of the plot.
%       scale_       - Label for the colorbar.
%
%   OUTPUTS:
%       A figure displaying the functional connectivity matrix.

    topMargin = 0.2; % Margin at the top of the figure

    % Create the figure with desired properties
    fig = figure('Position', [10, 50, 1300, 700]);
    
    % Calculate the new position of the axes
    axesPosition = [0.1, topMargin, 0.85, 0.92 - topMargin];

    % Create the axes within the figure with adjusted position
    ax = axes('Parent', fig, 'Position', axesPosition);
    
    % Display the matrix as an image
    imagesc(ax, input_matrix);

    [rows, ~] = size(input_matrix); % Get the number of rows from the matrix

    space = 1; % Interval for plotting

    % Set x-tick labels with replacement of underscores and rotate them
    set(gca, 'XTickLabel', strrep(labels(1:space:rows), '_', ' '), 'XTick', 1:space:rows);
    rotateticklabel(gca, 'x', 90, 8, 0);

    % Set y-tick labels with replacement of underscores and rotate them
    set(gca, 'YTickLabel', strrep(labels(1:space:rows), '_', ' '), 'YTick', 1:space:rows);
    rotateticklabel(gca, 'y', 0, 8, 0);

    % Define positions for x and y grid lines
    Xtick_pos = 1.5:rows;
    Ytick_pos = 1.5:rows;
    xline(Xtick_pos, '-', 'Color', [0.5 0.5 0.5]); % Draw x grid lines
    yline(Ytick_pos, '-', 'Color', [0.5 0.5 0.5]); % Draw y grid lines

    % Indicate brain system with black lines
    Region_Index = [1 4 10 17 26 31 40 47 52 59 67 79 87 95 100 110 120 133 149 158 167];
    xline(Region_Index+0.5, '-k', 'LineWidth', 0.9); % Vertical black lines
    yline(Region_Index+0.5, '-k', 'LineWidth', 0.9); % Horizontal black lines

    % Add colorbar and set its label
    cb = colorbar;
    cb.Label.String = scale_;
    
    % Set the colormap
    colormap('jet');
    
    % Set the title of the plot
    title(title_)
end
