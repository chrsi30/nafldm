% This script setups all necessary paths,
% loads the the data for training and validation and
% sets up necessary model variables.  

addpath('./Utility/') ;  
addpath('./Utility/Objective functions/') ; 
addpath('./Utility/Objective functions/cost_calculation') ; 
addpath('./Utility/Simulations/') ; 
addpath('./PLOT/') ;
addpath('./ESTIMATION/') ;

objModel = SBmodel(strcat(modelName,'.txt')); %creates a variable representing a SBmodel for modelName.txt
[pNames, p0] = SBparameters(objModel); ic0 = SBinitialconditions(objModel); func_mex_model = str2func(modelName);
utility.p0 = p0;
utility.pNames = pNames;
utility.objModel = objModel;
utility.ic0=ic0;

utility.modelName=modelName;

run('../Data/Load_data.m')

dgf_indexes 

