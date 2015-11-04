% Voltage & Current Data from Metal 3-D Printing Processing
% August 4, 2015
% Created by Yuenyong Nilsiam
% For details, http://www.mdpi.com/2075-1702/3/4/339 and
% http://www.appropedia.org/Integrated_Voltage%E2%80%94Current_Monitoring_and_Control_of_Gas_Metal_Arc_Weld_Magnetic_Ball-Jointed_Open_Source_3-D_Printer#Source

function result=removeNonZeroNoise(data,nth)
    % remove non zero noise, non zero values that occur between layers
    % use diff func to find the eadge of each layer in data
    edgeLayer = diff([(data(:) ~= 0);0]);
    % find the start and end index of each layer
    indices = [find(edgeLayer > 0)+1 find(edgeLayer < 0)];
    % leght of each layer
    lengthy = indices(:,2) - indices(:,1) + 1;
    % layer that smaller than the threshold
    indx = lengthy <= nth;%smallest layer should be bigger than this
    % indices of non zero noise
    indices = indices(indx,:);
    % row number of indices
    [rownum,~] = size(indices);
    % set non zero noise to zero
    for i=1:rownum
        data(indices(i,1):indices(i,2)) = 0;
    end
    % return the data without non zero noise
    result = data;
end