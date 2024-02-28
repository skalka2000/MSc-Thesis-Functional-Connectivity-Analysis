function new_FC = full2reg(FC)
% full2reg groups a functional connectivity matrix according to predefined cortical divisions 
% and calculates the mean connectivity of each grouped region for all subjects.
%
% INPUT:
%   FC : A 3D matrix where the third dimension represents different subjects
%        and the first two dimensions represent the connectivity matrix for each subject.
%
% OUTPUT:
%   new_FC : A 3D matrix where the first two dimensions represent the grouped mean 
%            connectivity by cortical divisions for each subject, and the third dimension represents subjects.
    
    % Determine the size of the FC matrix.
    rows = size(FC, 1);
    
    % Define cortical division indices based on the input matrix size.
    if rows == 180
        Region_Index = [0 1 4 10 17 26 31 40 47 52 59 67 79 87 95 100 110 120 133 149 158 167 180];
    elseif rows == 360
        Region_Index = [0 1 4 10 17 26 31 40 47 52 59 67 79 87 95 100 110 120 133 149 158 167 180 181 184 190 197 206 211 220 227 232 239 247 259 267 275 280 290 300 313 329 338 347 360];
    end
    
    % Calculate the total number of distinct cortical divisions.
    num_areas = length(Region_Index) - 1;
    
    % Initialize the output matrix.
    new_FC = zeros(num_areas, num_areas, 100);
    
    % Iterate through each region pair.
    for i1 = 1:num_areas
        for i2 = 1:num_areas
            regions1 = (Region_Index(i1) + 1):(Region_Index(i1 + 1));
            regions2 = (Region_Index(i2) + 1):(Region_Index(i2 + 1));
            
            % Calculate mean FC for each subject and for the current region pair.
            for i3 = 1:100
                sum_of_region = 0;
                num_summed_regions = 0;
                for i4 = regions1
                    for i5 = regions2
                        if i4 ~= i5
                            sum_of_region = sum_of_region + FC(i4, i5, i3);
                            num_summed_regions = num_summed_regions + 1;
                        end
                    end
                end
                % Compute and store the mean FC value.
                mean_region_FC = (num_summed_regions > 0) * sum_of_region / max(1, num_summed_regions) + (num_summed_regions == 0);
                new_FC(i1, i2, i3) = mean_region_FC;
            end
        end
    end
end
