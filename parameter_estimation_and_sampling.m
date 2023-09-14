clear all
close all
clc

%%% Check toolboxes
if ~contains(path, "SBPD")
    disp('Please check SBtoolbox installation - download from: http://www.sbtoolbox2.org/main.php')
else

%%
msg = "What to run?";
menu_opt = [ "Run parameter estimation - using the training dataset (figure 2)"...
    "Run parameter MCMC sampling - PESTO toolbox (figure 2)"...
    "Run calibration to validation data baseline - using the parameterset correpsonding to the best modelfit"...
    "Run calibration to validation data baseline - looping over all sampled parametersets (figure 3,4,5 and 6)" ];

choice = menu(msg,menu_opt);
%%
addpath('./Models/');

modelName = 'nafldv5'; 

cd ./Models
SBPDmakeMEXmodel(SBmodel(strcat(modelName,'.txt')))
cd ..


if choice == 1 
run('./CODE/setup')
run('./CODE/ESTIMATION/run_estimation_ess.m')

elseif choice == 2
run('./CODE/setup')
run('./CODE/ESTIMATION/run_sampling.m')

elseif choice == 3
run('./CODE/setup')
run('./CODE/ESTIMATION/run_calibration.m')

elseif choice == 4
run('./CODE/setup')
run('./CODE/ESTIMATION/run_calibration_based_on_sampling.m')
end



end