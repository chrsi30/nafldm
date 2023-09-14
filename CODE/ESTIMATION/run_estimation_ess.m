%%  
if ~contains(path, "MEIGO")
    disp('Please check that the MIEGO toolbox (https://doi.org/10.1186/1471-2105-15-136) is installed.');
    disp('The optimization algorithm could also be changed to e.g., https://se.mathworks.com/help/gads/particleswarm.html ');
else


%% Setup
[problem, opts , bounds_size_string ] = options_ess_b2(pNames ); % set opt options
utility.bounds_size_string = bounds_size_string;

%%
warning('off','all')
optim_algorithm =  'ess' ;  %'ess'; % 'multistart'; %  'cess'; %
Results = MEIGO(problem,opts,optim_algorithm, func_mex_model, D, utility ,  1 ); 
fitting_speed     = Results.time(end);
best_fs           = Results.fbest;
parameters_ess    = Results.xbest'; 
X=parameters_ess;
w = warning ('on','all');
%%

folder=  ['../../Results/NEW/Estimation_ESS/Training/' modelName   '/'  utility.bounds_size_string  ];
if ~exist(folder,'dir')
    mkdir(folder)
end

save(  [ folder '/optESS'  sprintf( '(%.2f),' ,Results.fbest) datestr(now,'yymmdd-HHMMSS') '.mat' ]  ,'Results')



end




