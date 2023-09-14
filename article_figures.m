
%%% This script will plot all article figures 2 - 7.

clear all
close all
clc

warning 'off'

%%% Check toolboxes
if ~contains(path, "SBPD")
    disp('Please check SBtoolbox installation - download from: http://www.sbtoolbox2.org/main.php')
else

%%
msg = "Which model to use?";
menu_opt = [ "Figure. 2" ...
             "Figure. 3" ...
             "Figure. 4" ...
             "Figure. 5" ...
             "Figure. 6" ...
             "Figure. 7"  ];

choice = menu(msg,menu_opt);


%%
addpath('./Models/');
if choice == 6
modelName = 'nafldv5_IR_Hall'; 
else
modelName = 'nafldv5'; 
end
cd ./Models
SBPDmakeMEXmodel(SBmodel(strcat(modelName,'.txt')))
cd ..

%%
if choice == 1 
run('./CODE/setup')
disp('Calculating the model uncetraitiy based on the sampled parametersets - this might take a while...')
run('./CODE/PLOT/plot_Figure_2.m') ;

elseif choice == 2
run('./CODE/setup')
run('./CODE/PLOT/plot_Figure_3.m') ;
    
elseif choice == 3
run('./CODE/setup')
run('./CODE/PLOT/plot_Figure_4.m') ;

elseif choice == 4
run('./CODE/setup')
disp('Calculating the model uncetraitiy based on the sampled parametersets - this might take a while...')
run('./CODE/PLOT/plot_Figure_5.m') ;    

elseif choice == 5
run('./CODE/setup')
run('./CODE/PLOT/plot_Figure_6.m') ;    

elseif choice == 6
run('./CODE/setup')
run('./CODE/PLOT/plot_Figure_7.m') ;    

end
end