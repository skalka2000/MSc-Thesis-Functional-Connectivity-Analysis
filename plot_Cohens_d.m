function plot_Cohens_d(input_matrix, labels, title_)
% plot_Cohens_d Visualizes a matrix of Cohen's d values.
%
%   INPUT:
%       input_matrix - A square matrix containing Cohen's d values.
%       labels       - Cell array containing labels: brain region names.
%       title_       - String for the plot title.

    % Margin for the top of the plot
    topMargin = 0.2;

    % Create a figure with specified size and position
    fig = figure('Position', [10, 50, 1300, 700]);

    % Define a position for the axes considering the margin
    axesPosition = [0.1, topMargin, 0.85, 0.92 - topMargin];

    % Create axes inside the figure at the specified position
    ax = axes('Parent', fig, 'Position', axesPosition);

    % Display the input matrix as an image
    imagesc(ax, input_matrix);
    fig = imagesc(input_matrix);

    % Get the size of the input matrix
    [rows, ~] = size(input_matrix);

    % Define spacing for x and y axis ticks
    spacex = 1;
    spacey = 1;

    set(fig, 'AlphaData', ~isnan(input_matrix));

    % Set the x-axis labels and ticks
    set(gca, 'XTickLabel', strrep(labels(1:spacex:rows), '_', ' '), 'XTick', 1:spacex:rows);
    rotateticklabel(gca, 'x', 90, 8, 0);  % Rotate x-axis labels

    % Set the y-axis labels and ticks
    set(gca, 'YTickLabel', strrep(labels(1:spacey:rows), '_', ' '), 'YTick', 1:spacey:rows);
    rotateticklabel(gca, 'y', 0, 8, 0);  % Rotate y-axis labels 

    Xtick_pos = 1.5:rows;
    Ytick_pos = 1.5:rows;
    xline(Xtick_pos, '-', 'Color', [0.5 0.5 0.5]);
    yline(Ytick_pos, '-', 'Color', [0.5 0.5 0.5]);

    % Draw lines indicating boundaries of specific cortical divisions
    Region_Index = [1 4 10 17 26 31 40 47 52 59 67 79 87 95 100 110 120 133 149 158 167];
    xline(Region_Index+0.5, '-k', 'LineWidth', 0.9);
    yline(Region_Index+0.5, '-k', 'LineWidth', 0.9);

    % Add a colorbar to the figure
    cb = colorbar;
    cb.Label.String = 'Cohen''s d';  % Label for the colorbar

    % Use the 'jet' colormap
    colormap('jet');

    % Set the title of the plot
    title(title_)
end
