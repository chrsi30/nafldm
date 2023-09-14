function[ s_b, s_d ]= f_sim_Taskinen_2017( theta ,func_mex_model, D, utility )


p = [ theta  ones(1,length(utility.pNames) - length(theta))    ] ;

p( ismember(utility.pNames,'EI0')) = D.Taskinen2017.HC_F.EI.kcal.Value(1);  % Energy intake before dietary intervention
p( ismember(utility.pNames,'EI'))  = D.Taskinen2017.HC_F.EI.kcal.Value(1); %  Energy intake before dietary intervention % <-- used for steady-state simulation EI/EI0 = 1


ic = utility.ic0 ;


p( ismember(utility.pNames, 'cf' ))   = D.Taskinen2017.HC_F.EI.C.Value(1)/100;  %  % Diet carbohydrate fraction before intervention % <-- used for steady-state simulation ff/f0 = 1
p( ismember(utility.pNames, 'ff' ))   = D.Taskinen2017.HC_F.EI.F.Value(1)/100;  % Diet fat fraction before intervention

p( ismember(utility.pNames, 'cf0' ))  = D.Taskinen2017.HC_F.EI.C.Value(1)/100; 
p( ismember(utility.pNames, 'ff0' ))  = D.Taskinen2017.HC_F.EI.F.Value(1)/100;

%% Simulation
% The study diet provided approximately 4% energy from carbohydrate, 72% energy from fat and 24% energy from
% protein whereas the corresponding macronutrient composition in the baseline diet was 40%, 42% and 18%, respectively

% Basline
pss =p; 

s_b = func_mex_model(0:1:1000, ic ,pss); ic1 = s_b.statevalues(end,:);

% Intervention

p( ismember(utility.pNames,'EI'))  = D.Taskinen2017.HC_F.EI.kcal.Value(2); %  % Energy intake during dietary intervention

p( ismember(utility.pNames, 'cf' ))  = D.Taskinen2017.HC_F.EI.C.Value(2)/100;  % Diet carbohydrate fraction during intervention
p( ismember(utility.pNames, 'ff' ))  = D.Taskinen2017.HC_F.EI.F.Value(2)/100; % Diet fat fraction during intervention

t  = 0:0.1:84; % Manually set

s_d = func_mex_model(t , ic1, p);
