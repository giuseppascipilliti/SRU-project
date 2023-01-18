%% 
%% 
clc;
clear all;
close all;
load("sru_4.mat")

inputs=zscore(l4_in);
outputs=zscore(l4_out3);

% inputs=(l4_in);
% outputs=(l4_out3);

% endd= 6720; % take a 2/3 of the dataset for the learning process and the rest for the validation and test
%inputs_test=l4_in(endd+1:end,:);
%targets_test=l4_out(endd+1:end,:);


% The regressors which have been selected for each variable : k-1, k-3,
% k-5, k-7, k-9.
% Matrix of Regressors for the input and for the output

RegInputs=model_input(inputs);
RegOutputs=model_output(outputs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Now it's necessary to create che patterns related to the 1st and 2nd
% derivatives for each variable. 
% The important consideration that has to be made is the fact that these two 
% have to be sinchronized with the k istant.

firstDerivative=incrementalRatio(inputs,1);
secondDerivative=incrementalRatio(firstDerivative,2);

% Creation of the inputs Matrix

DerInputs=creationMatrix(inputs, firstDerivative, secondDerivative);
DerOutputs=outputs(3:end,:);
