function[ s_b, s_d ]= f_sim_Johnston_2013_HC_ISO_F( theta ,func_mex_model, D, utility , flag_plot )


p = [ theta  ones(1,length(utility.pNames) - length(theta))    ] ;

p( ismember(utility.pNames,'EI0')) = D.Johnston2013.HC_ISO_F.EI.kcal.Value(1); % Energy intake before dietary intervention
p( ismember(utility.pNames,'EI'))  = D.Johnston2013.HC_ISO_F.EI.kcal.Value(1);  % Energy intake before dietary intervention % <-- used for steady-state simulation EI/EI0 = 1


ic = utility.ic0 ;

p( ismember(utility.pNames, 'cf' ))   = D.Johnston2013.HC_ISO_F.EI.C.Value(1)/100; % Diet carbohydrate fraction before intervention % <-- used for steady-state simulation ff/f0 = 1
p( ismember(utility.pNames, 'ff' ))   = D.Johnston2013.HC_ISO_F.EI.F.Value(1)/100; % Diet fat fraction before intervention

p( ismember(utility.pNames, 'cf0' ))  = D.Johnston2013.HC_ISO_F.EI.C.Value(1)/100; 
p( ismember(utility.pNames, 'ff0' ))  = D.Johnston2013.HC_ISO_F.EI.F.Value(1)/100;

%% Simulation

% Baseline
pss =p; 

s_b = func_mex_model(0:1:1000, ic ,pss); ic1 = s_b.statevalues(end,:);

% Intervention

p( ismember(utility.pNames,'EI'))  = D.Johnston2013.HC_ISO_F.EI.kcal.Value(2); % Energy intake during dietary intervention

p( ismember(utility.pNames, 'cf' ))  = D.Johnston2013.HC_ISO_F.EI.C.Value(2)/100; % Diet carbohydrate fraction during intervention
p( ismember(utility.pNames, 'ff' ))  = D.Johnston2013.HC_ISO_F.EI.F.Value(2)/100; % Diet fat fraction during intervention

if nargin > 4
t  = 0:0.01:14; % Manually set

else
t  = 0:0.1:14; % Manually set
end

s_d = func_mex_model(t , ic1, p);
