function [problem, opts]= options_ess_b2_calibration(pNames, flag  , num_s2c , bof , study_type_flag)

if flag  == 5 
    num_opt = find(strcmp('cf', pNames)) - 1;   
elseif flag == 6 
    num_opt = 7;
    
elseif  flag == 7
    num_opt  = 1;
    
elseif flag == 8
    num_opt  = 2;
    
elseif flag == 9
    num_opt  = 4;

elseif  flag == 10
    num_opt  =5;
end

tmp_x_U = ones(1, num_opt*num_s2c)*(1 + bof) ;
tmp_x_L = ones(1, num_opt*num_s2c)*(1 - bof) ;


%%

sG = ones(1,length(tmp_x_L) ) ;

%%

%% MEIGO OPTIONS I (COMMON TO ALL SOLVERS):
opts.ndiverse     = 'auto'; %100; %500; %5; %
opts.maxtime      = 20; % In cess this option will be overwritten
opts.maxeval      = 1e9;
opts.log_var      = 1:length(sG);

opts.local.solver = 'dhc'; %'dhc'; %'fmincon'; %'nl2sol'; %'mix'; %
opts.local.finish = opts.local.solver;
opts.local.bestx = 0;

problem.x_L       = tmp_x_L;
problem.x_U       = tmp_x_U;


if study_type_flag == 1

problem.f         = 'fobj_ESS_calib';

elseif study_type_flag == 2
problem.f         = 'fobj_ESS_ACC_2';
end

problem.x_0       = sG;

% %% MEIGO OPTIONS II (FOR ESS AND MULTISTART):
opts.local.iterprint = 1;

%% MEIGO OPTIONS III (FOR ESS ONLY):
opts.dim_refset   = 'auto'; %

%% OPTIONS AUTOMATICALLY SET AS A RESULT OF PREVIOUS OPTIONS:
if(strcmp(opts.local.solver,'fmincon'))
    opts.local.use_gradient_for_finish = 1; %DW: provide gradient to fmincon
else
    opts.local.use_gradient_for_finish = 0; %DW: provide gradient to fmincon
end
opts.local.check_gradient_for_finish = 0; %DW: gradient checker
end


