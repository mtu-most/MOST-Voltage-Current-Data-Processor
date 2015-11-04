% Voltage & Current Data from Metal 3-D Printing Processing
% August 4, 2015
% Created by Yuenyong Nilsiam
% For details, http://www.mdpi.com/2075-1702/3/4/339 and
% http://www.appropedia.org/Integrated_Voltage%E2%80%94Current_Monitoring_and_Control_of_Gas_Metal_Arc_Weld_Magnetic_Ball-Jointed_Open_Source_3-D_Printer#Source

function [avg,stdErr2] = findAvg2Std(data)
    % find average and 2-standard error
    % use diff func to find the eadge of each layer in data
    edgeLayer = diff([(data(:) ~= 0); 0]);
    % find the start and end index of each layer
    indices = [find(edgeLayer > 0)+1 find(edgeLayer < 0)];
    % leght of each layer
    lengthy = indices(:,2) - indices(:,1);
    % row number of indices
    [rownum,~] = size(indices);
    % initial variables
    avg = zeros(rownum,1);
    stdErr2 = zeros(rownum,1);
    % calculate average and 2-standard error
    for i=1:rownum
        avg(i) = mean(data(indices(i,1):indices(i,2)));
        stdErr2(i) = 2*std(data(indices(i,1):indices(i,2)))/sqrt(lengthy(i));
    end
end