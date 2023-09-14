function [problem, opts , bounds_size_string ] = options_ess_b2(pNames )

num_opt = find(strcmp('cf', pNames)) - 1;

ub_lim = 1e2;
lb_lim  = 1e-2;

bounds_size_string = [ 'p_bounds(' num2str(lb_lim) ','   num2str(ub_lim)     ')'           ] ;

tmp_x_U = ones(1,length(1:num_opt))*ub_lim;
tmp_x_L  = ones(1,length(1:num_opt))*lb_lim;

sG = ones(1,length(tmp_x_L)  ) ;

%% 

%% MEIGO OPTIONS I (COMMON TO ALL SOLVERS):
opts.ndiverse     = 'auto'; %100; %500; %5; %
opts.maxtime      = 30; % In cess this option will be overwritten
opts.maxeval      = 1e9;
opts.log_var      = 1:length(sG);

opts.local.solver = 'dhc'; %'dhc'; %'fmincon'; %'nl2sol'; %'mix'; %
opts.local.finish = opts.local.solver;
opts.local.bestx = 0;

problem.x_L       = tmp_x_L;
problem.x_U       = tmp_x_U;

problem.f         = 'fobj_ESS';
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


