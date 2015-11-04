% Voltage & Current Data from Metal 3-D Printing Processing
% August 4, 2015
% Created by Yuenyong Nilsiam
% For details, http://www.mdpi.com/2075-1702/3/4/339 and
% http://www.appropedia.org/Integrated_Voltage%E2%80%94Current_Monitoring_and_Control_of_Gas_Metal_Arc_Weld_Magnetic_Ball-Jointed_Open_Source_3-D_Printer#Source

% PLEASE make sure that your data file has complted columns in the last
% line

clear all;
close all;
clc;

%set format
format long;

% get file name
[fileName,pathName] = uigetfile({'*.*','All Files'},'Select Data file...');
% load data into workspace
cvData=load(strcat(pathName,fileName));

% time in negative millisecond
time_neg_ms = cvData(:,1);
% Current or Voltage specify
c_v = cvData(:,2);
% value of current or voltage
value = cvData(:,3);
% check for 'inf' then set them to zeros
infInd = isinf(value);
value(infInd) = 0;

% valid index for current
currentInd = c_v == 1;
% valid index for voltage
voltageInd = c_v == 0;

% voltage time
vTime = time_neg_ms(voltageInd);
%To convert the negative millisecond to the positive second
vTime = (vTime - vTime(1))/1000;

% voltage values
vValue = value(voltageInd);
% clean data
clearInd = vValue < 1;
% set non zero noise to zero
vValue(clearInd) = 0;
% remove noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nth = 5; %default is 5
zth = 50; %default is 50
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%disp('Voltage Layer Indices');
vValue = removeNonZeroNoise(vValue,nth);
% %find first and last non zero index
[fi,li] = findFL(vValue);
vValue(fi:li) = removeZeroNoise(vValue(fi:li),zth);

%find avg and 2 Std Err
[voltageAvg, voltage2StdErr] = findAvg2Std(vValue);
vLayer = (1:length(voltageAvg)).';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% current time
cTime = time_neg_ms(currentInd);
%To convert the negative millisecond to the positive second
cTime = (cTime - cTime(1))/1000;

% current values
cValue = value(currentInd);
% clean data
clearInd = cValue < 2;
% set non zero noise to zero
cValue(clearInd) = 0;
% remove noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nth = 5; %default is 5
zth = 50; %default is 50
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Current Layer Indices');
cValue = removeNonZeroNoise(cValue,nth);
%find first and last non zero index
[fi,li] = findFL(cValue);
%remove zero-noise
cValue(fi:li) = removeZeroNoise(cValue(fi:li),zth);

% find avg and 2 Std Err
[currentAvg, current2StdErr] = findAvg2Std(cValue);
cLayer = (1:length(currentAvg)).';

if (length(cLayer) ~= length(vLayer))
    h = msgbox('Error: Layer number are different');
else
    %plot data
    fig = figure('Name',strcat('Voltage and Current Data Result of: ', fileName));
   % plot voltage vs time (sec)
    subplot(2,2,1);plot(vTime,vValue);
    ylabel('Voltage (V)');
    xlabel('Time (sec)');
    xlim([0 vTime(end)*1.05]);

    %plot avg and error bar
    subplot(2,2,2);errorbar(vLayer,voltageAvg,voltage2StdErr);
    ylabel('Average Voltage (V)');
    xlabel('Layer #');
    xlim([0 vLayer(end)*1.05]);

    %plot current vs time (sec)
    subplot(2,2,3);plot(cTime,cValue);
    ylabel('Current (A)');
    xlabel('Time (sec)');
    xlim([0 cTime(end)*1.05]);

    %plot avg and error bar
    subplot(2,2,4);errorbar(cLayer,currentAvg,current2StdErr);
    ylabel('Average Current (A)');
    xlabel('Layer #');
    xlim([0 vLayer(end)*1.05]);

    %export processed data to excel file, separate each column by space
    T = table(vLayer,voltageAvg,voltage2StdErr,currentAvg,current2StdErr);
    writetable(T,strcat(pathName,fileName,'_Processed.csv'),'Delimiter',' ');

    %csv file is save in the same folder as the input file

end

% save figure to the same folder as the input file
savefig(fig,strcat(pathName,fileName,'.fig'));



