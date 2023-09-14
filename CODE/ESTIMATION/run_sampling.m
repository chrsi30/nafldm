%%  
if ~contains(path, "PESTO")
    disp('Please check that the PESTO toolbox (https://doi.org/10.1093/bioinformatics/btx676) is installed.');
else

warning 'off'

[problem ] = options_ess_b2(utility.pNames) ;

anonymous = @(theta) fobj_MS( theta ,func_mex_model, D, utility );  
  
parameters.name = string(1:1:length(problem.x_U));
parameters.max=  log( problem.x_U );
parameters.min=  log( problem.x_L );
parameters.number = length(parameters.name);

%% Multi-start local optimization
% A multi-start local optimization is performed within the bounds defined in
% parameters.min and .max in order to infer the unknown parameters from 
% measurement data. Therefore, a PestoOptions object is created and
% some of its properties are set accordingly.

optionsPesto = PestoOptions();
optionsPesto.obj_type = 'negative log-posterior';
optionsPesto.n_starts = 50;
optionsPesto.comp_type = 'sequential';
optionsPesto.mode = 'visual';
optionsPesto.objOutNumber=1;
%optionsPesto.localOptimizerOptions = optimset('GradObj', 'off' );

parameters = getMultiStarts(parameters, anonymous, optionsPesto);

folder=  ['./Results/NEW/Estimation_MS/' modelName '/'  ];

if ~exist(folder,'dir')
    mkdir(folder)
end

%% Markov Chain Monte Carlo sampling -- Parameters
% Values for the parameters are sampled by using an Parallel Tempering (PT)
% algorithm. This way, the underlying probability density of the parameter 
% distribution can be captured. Since only one temperature is used, this is
% effectively an adapted Metropolis algorithm single-chain algorithm.

% Building a struct covering all sampling options:
optionsPesto.MCMC = PestoSamplingOptions();
optionsPesto.MCMC.nIterations = 1e5 ;%2e4; %% This is the most important setting, covering how many iterations to be performed, here i think the minimum is 1e5 and above, especially now, as we only want the really good (i.e significant) parameter vectors
optionsPesto.MCMC.mode = optionsPesto.mode;

%% Using RAMPART  Most of this should be left as is, however look in the file called RAMPARTOPTIONS in @RAMPARTOPTIONS folder to see what each setting does
optionsPesto.MCMC.samplingAlgorithm     = 'RAMPART'; % region based parallel tempering (RAMPART)
optionsPesto.MCMC.RAMPART.nTemps           = 10; % 10
optionsPesto.MCMC.RAMPART.exponentT        = 1000;
optionsPesto.MCMC.RAMPART.maxT             = 2000;
optionsPesto.MCMC.RAMPART.alpha            = 0.51;
optionsPesto.MCMC.RAMPART.temperatureNu    = 1e3;
optionsPesto.MCMC.RAMPART.memoryLength     = 1;
optionsPesto.MCMC.RAMPART.regFactor        = 1e-8;
optionsPesto.MCMC.RAMPART.temperatureEta   = 50; % 10

optionsPesto.MCMC.RAMPART.trainPhaseFrac   = 0.1;
optionsPesto.MCMC.RAMPART.nTrainReplicates = 5;

optionsPesto.MCMC.RAMPART.RPOpt.rng                  =  1 ;
optionsPesto.MCMC.RAMPART.RPOpt.nSample              = floor(optionsPesto.MCMC.nIterations*optionsPesto.MCMC.RAMPART.trainPhaseFrac)-1;
optionsPesto.MCMC.RAMPART.RPOpt.crossValFraction     = 0.2;
optionsPesto.MCMC.RAMPART.RPOpt.modeNumberCandidates = 1:20;
optionsPesto.MCMC.RAMPART.RPOpt.displayMode          = 'text';
optionsPesto.MCMC.RAMPART.RPOpt.maxEMiterations      = 100;
optionsPesto.MCMC.RAMPART.RPOpt.nDim                 = parameters.number;
optionsPesto.MCMC.RAMPART.RPOpt.nSubsetSize          = 1000;
optionsPesto.MCMC.RAMPART.RPOpt.lowerBound           = parameters.min;
optionsPesto.MCMC.RAMPART.RPOpt.upperBound           = parameters.max;
optionsPesto.MCMC.RAMPART.RPOpt.tolMu                = 1e-4 * (parameters.max(1)-parameters.min(1));
optionsPesto.MCMC.RAMPART.RPOpt.tolSigma             = 1e-2 * (parameters.max(1)-parameters.min(1));
optionsPesto.MCMC.RAMPART.RPOpt.dimensionsToPlot     = [1,2];
optionsPesto.MCMC.RAMPART.RPOpt.isInformative        = [1,1,ones(1,optionsPesto.MCMC.RAMPART.RPOpt.nDim-2)];


optionsPesto.MCMC.theta0 = parameters.MS.par(:,1);
optionsPesto.MCMC.sigma0 = 0.5 * inv(squeeze(parameters.MS.hessian(:,:,1)));


parameters = getParameterSamples(parameters, anonymous, optionsPesto);

save_dir_folder = ['./Results/NEW/Sampling_MCMC/' modelName  '/' ] ;

if ~exist(save_dir_folder)
    mkdir(save_dir_folder)
end

save([ save_dir_folder 'Sampling_parameters_' datestr(now,'yymmdd-HHMMSS') ],'parameters')


end




