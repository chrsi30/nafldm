A Unified Minimal Framework to study Liver Steatosis Dy-namics in Response to Different Diet and Drug Interventions

This repository contains all code and models need to repdocue all results. 

Created : 2023-09-12 by Christian Simonsson. 

 
!! Several toolboxes are needed to run the code. Before continuing, please install:  !! 
1. SBtoolbox - http://www.sbtoolbox2.org/main.php
2. MATLAB Support for MinGW-w64 C/C++ Compiler https://se.mathworks.com/matlabcentral/fileexchange/52848-matlab-support-for-mingw-w64-c-c-compiler 
3. MEIGO  - http://gingproc.iim.csic.es/meigo.html, https://github.com/gingproc-IIM-CSIC/MEIGO64
4. PESTO - https://github.com/ICB-DCM/PESTO 


The model is provided in the ./Models directory. Here the nafldv5 model is the base model used for figures 2-6, and the nafldv5_IR_HALL has the integrated body-composition model used ion figure 7.

All simulation scripts are provided in the ./CODE/UTILITY/Simulations directory. Here we used separate scripts simulation of each study.

To plot the article figures run the 'article_figures.m' script. Here one can chose which figure to plot via a menu.
The scripts for plotting each figure can be found in the ./CODE/PLOT/ directory. The parameter sets, and model simulation uncertainties can be found
in the ./Results/Article figures/ directory. 

Here we provide the sampled parameter sets for calculating the model training uncertainty, and the parameter set corresponding to the best model fit (figure 2, 5, 7).
We do not provide all ('raw') parameter sets for calculation of the model prediction uncertainty (to large files), instead we provide the collected model prediction uncertainties directly (figure 3,4,6). 
All parameter sets used for collecting the prediction uncertainty can be provided per request (christian.simonsson@liu.se). 

We have also provide all script used for running parameter estimation and parameter sampling. Run the provided 'parameter_estimation_and_sampling' script, or access the separate scripts in the ./CODE/ESTIMATION directory.
Also the objective function used for model training can be found in the ./CODE/UTILITY/Objective functions directory. The output will be saved in the ./Results/NEW/ directory. 

To note, the calibration is based on the result from the model training (either from parameter estimation or MCMC sampling). Thus, one of these must be run before any calibration can be done. 

For any questions or inquiries, please contact: christian.simonsson@liu.se







