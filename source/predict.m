close all, clear all, clc

%% load the dataset
data=xlsread('assign#2-time series data for students.xlsx');
dataTrain = data';

% plot the Training data
plot(data,'b');
legend('training data');
xlabel('Time');
ylabel('Values');
title('Training Data');
legend('location','NorthWest');

%% Feature Normalisation
mu = mean(dataTrain);
sig = std(dataTrain);
dataTrainStandardized = (dataTrain - mu) / sig;
%dataTestStandardized = (dataTest - mu) / sig;
XTrain = dataTrainStandardized(1:end);
YTrain = dataTrainStandardized(2:end);
%XTest = dataTestStandardized(1:end-1);

%% neural network setup

% converting matrix to cell datatype
XTrain=con2seq(XTrain);
T=con2seq(XTrain');
dataTest =con2seq(data(102:end)');
rng(15);

% Setting Bias Value
b=(sqrt(6))/sqrt(10+2);

% initialize the neural network
net.iw{1,1} = (-b + (2*b)*rand(10,0));
net=narnet(1:120,22);   
net.trainFcn='trainbfg';
net.trainParam.alpha = 0.01;
[Xs,Xi,Ai,Ts] = preparets(net,{},{},XTrain);

% specifying the partitions
net.divideParam.trainRatio = 75/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 10/100;
%% training the neural net
net = train(net,Xs,Ts,Xi,Ai);
% creating the closed loop net 
[netc,xic,aic] = closeloop(net,Xi,Ai);

%% predicting the values from 125:144

[YPred,xfc,afc] = netc(cell(0,20),xic,aic);
YPred=cell2mat(YPred);
YPred = sig*YPred + mu;
filename = 'Predicted data.xlsx';
xlswrite(filename,YPred',1);
%% final plots 

% plot the predicted values
figure(2);
plot(125:144,YPred,'r-o');
legend('Forecast');
xlabel('Timesteps');
ylabel('Observed Values');
title('Forecast Values (125:144)');
legend('location','NorthWest');

% plot the training and predicted values 
figure(3)
plot(dataTrain,'b');
hold on;
plot(125:144,YPred,'r-o');
legend('Training Data','Forecast Data');
xlabel('Timesteps');
ylabel('Values');
title('Forecast Data (125:144)');
legend('location','NorthWest');


