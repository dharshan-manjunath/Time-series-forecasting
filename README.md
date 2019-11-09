# Time-series-forecasting
Time series forecasting with nonlinear autoregressive neural network on weather station data
 
Steps for prediction the values from 125 to 144 using the given model

1. run the function predict.m , and include the file time series "assign#2-time series data for students.xlsx" 
in the same folder
   <syntax> 
   input: dataTrain; %% where dataTrain is a row matrix of size (1,124)
   output: YPred will be the output matrix of size (1,20) 

2. The predicted values will be written on newly created excel file "Predicted data.xlxs" 
	Note: If the no xlxs server on the computer a warning will be displayed in that case file will be
		as csv format i.e "Predicted data.csv"
