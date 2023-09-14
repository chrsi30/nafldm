function[ s_b, s_d ]= f_sim_Beysen_2020( theta ,func_mex_model, D, utility  )

p = [ theta  ones(1,length(utility.pNames) - length(theta))    ] ;

EI = 3115;% kcal per day;
p( ismember(utility.pNames,'EI0')) = EI; % Energy intake before dietary intervention
p( ismember(utility.pNames,'EI'))  = EI; % Energy intake during dietary intervention

p( ismember(utility.pNames, 'cf' ))   = 0.4;  % Diet carbohydrate fraction during intervention
p( ismember(utility.pNames, 'ff' ))   = 0.42;  % Diet fat fraction during intervention

p( ismember(utility.pNames, 'cf0' ))  = 0.4;   % Diet carbohydrate fraction before intervention
p( ismember(utility.pNames, 'ff0' ))  = 0.42;  % Diet fat fraction before intervention

ic = utility.ic0 ;

%% Simulation

pss =p; 
s_b = func_mex_model(0:1:1000,[],pss); ic1 = s_b.statevalues(end,:);

% Intervention
if nargin > 4
t  = 0:0.01:D.Beysen2020.FT_4101_3mg.LF.Time(end); 
else
t  = 0:0.1:D.Beysen2020.FT_4101_3mg.LF.Time(end); 
end


s_d = func_mex_model(t , ic1, p);


