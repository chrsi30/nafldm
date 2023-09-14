%%  
if ~contains(path, "MEIGO")
    disp('Please check that the MIEGO toolbox (https://doi.org/10.1186/1471-2105-15-136) is installed.');
    disp('The optimization algorithm could also be changed to e.g., https://se.mathworks.com/help/gads/particleswarm.html ');
else

setup_calibration

load('../../Results/Article figures/figure2/optESS(5.04)Best fit training data.mat'); 
objf = Results.fbest;
limit_main_pool = objf + chi2inv(0.95,  1  ) ; 

%%
utility.bof_string             = bof_string;
utility.study_type_string      = study_type_string;

%%
dir_parameter_files = ['../../Results/NEW/Sampling_MCMC/'  modelName '/' ] ;
files =  dir ( fullfile(  [ dir_parameter_files,'*.mat']) );

%%

if ~isempty( files )

    c = 0;
    for kk = 1:size( files ,1)

        disp(['running  - ' files(kk).name ])
        load( [dir_parameter_files files(kk).name ])


        S =   parameters.S.par(:,1:end)  ;


        for jj = 1:size(S,2)

            pmain =  S(:,jj) ;

            cost =  fobj_ESS( pmain ,func_mex_model, D, utility ,0  ) ;
           
            if cost <= limit_main_pool

                for itr=1:1
                    warning('off','all')
                    optim_algorithm =  'ess' ;  %'ess'; % 'multistart'; %  'cess'; %

                    Results = MEIGO(problem,opts,optim_algorithm, func_mex_model, D, utility  , pmain , flag , prediction_flag , 1);

                    fitting_speed         = Results.time(end);
                    best_fs                    = Results.fbest;
                    parameters_ess    = Results.xbest';
                    X=parameters_ess;
                    w = warning ('on','all');


                    %%
                    theta = [ exp(pmain)' , Results.xbest] ;

                    folder=  ['../../Results/NEW/Estimation_ESS/Calibration/'  modelName   '/'  study_type_string  '/' bof_string  ];
                    if ~exist(folder,'dir')
                        mkdir(folder)
                    end

                    save(  [ folder '/optESS'  sprintf( '(%.2f),' ,Results.fbest) datestr(now,'yymmdd-HHMMSS') '.mat' ]  ,'theta')
                end

            end
        end


    end
else
disp('No sampled parametersets exist - please run MCMC sampling')
end

end
%%


