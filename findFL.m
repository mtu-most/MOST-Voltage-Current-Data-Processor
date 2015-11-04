% Voltage & Current Data from Metal 3-D Printing Processing
% August 4, 2015
% Created by Yuenyong Nilsiam
% For details, http://www.mdpi.com/2075-1702/3/4/339 and
% http://www.appropedia.org/Integrated_Voltage%E2%80%94Current_Monitoring_and_Control_of_Gas_Metal_Arc_Weld_Magnetic_Ball-Jointed_Open_Source_3-D_Printer#Source

function [fi,li]=findFL(data)
    %this func find the first and last value that not zero
    % find the edges of each layer
    edgeLayer = diff([(data(:) ~= 0); 0]);
    indices = [find(edgeLayer > 0)+1 find(edgeLayer < 0)];
    %first index that not zero
    fi = indices(1,1);
    %last index that not zero
    li = indices(end,2);
end