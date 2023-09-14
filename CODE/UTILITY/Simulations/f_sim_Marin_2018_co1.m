function[ s_b, s_d ]= f_sim_Marin_2018_co1( theta ,func_mex_model, D, utility  )


p = [ theta  ones(1,length(utility.pNames) - length(theta))    ] ;

EI = 3115;% kcal per day;
p( ismember(utility.pNames,'EI0')) = EI; % Energy intake before dietary intervention
p( ismember(utility.pNames,'EI'))  = EI; %   Energy intake before dietary intervention % <-- used for steady-state simulation EI/EI0 = 1


ic = utility.ic0 ;

p( ismember(utility.pNames, 'cf' ))   = 0.4; % % Diet carbohydrate fraction before intervention % <-- used for steady-state simulation ff/f0 = 1
p( ismember(utility.pNames, 'ff' ))   = 0.42;  % Diet fat fraction before intervention

p( ismember(utility.pNames, 'cf0' ))  = 0.4; 
p( ismember(utility.pNames, 'ff0' ))  = 0.42; 


%% Simulation
% The study diet provided approximately 4% energy from carbohydrate, 72% energy from fat and 24% energy from
% protein whereas the corresponding macronutrient composition in the baseline diet was 40%, 42% and 18%, respectively

% Basline
pss =p; 
s_b = func_mex_model(0:1:1000,[],pss); ic1 = s_b.statevalues(end,:);

% Intervention

p( ismember(utility.pNames, 'cf' ))  = 0.04; % Diet carbohydrate fraction during intervention
p( ismember(utility.pNames, 'ff' ))  = 0.72; % Diet fat fraction during intervention


if nargin > 4
t  = 0:0.01:D.Mardinoglu.co1.Time (end); 
else
t  = 0:0.1:D.Mardinoglu.co1.Time (end); 
end


s_d = func_mex_model(t , ic1, p);


