Voltage and Current Data Processor

The 'voltCurrentProcessor.m ' is a MATLAB program that process a data file containing measurements of voltage and current from the metal 3D printer. Four functions are used in the process and they are in four m-files:
	1. 'removeNonZeroNoise.m' is a function that remove non-zero noise, some non-zero values that appear among consecutive zero data, from the data.
	2. 'removeZeroNoise.m' is a function that remove zero-noise, some  zero values that appear among consecutive non-zero data, from the data.
	3. 'findFL.m' is a function that find the first and last non-zero data indexes.
	4. 'findAvg2Std.m' is a function that split data into layers and find the average and two standard error of each layer.
A data file should have four columns: (Please make sure that every line of data has four columns, especially the last line)
	1. Time steps in negative millisecond
	2. Voltage or Current identifier
	3. Voltage or Current value
	4. Unused column
In the beginning, the program (voltCurrentProcessor) will clean the data, removing noises. Then the program will separate the voltage and current data apart and convert the negative time in millisecond to the positive time in second starting from zero. The averages and the two standard error of voltage and current measurements of each layer are calculated after that. Finally, the voltage measurements, the current measurements, the averages and the two standard errors of each layer for both voltage measurements and the current measurements are plotted. The results, figure(.fig) and the average and the standard error data(.csv), are saved in the same folder as the input data file.

For details, http://www.mdpi.com/2075-1702/3/4/339 and
http://www.appropedia.org/Integrated_Voltage%E2%80%94Current_Monitoring_and_Control_of_Gas_Metal_Arc_Weld_Magnetic_Ball-Jointed_Open_Source_3-D_Printer#Source
