function[ s_b, s_d ]= f_sim_Lawitz_2018( theta ,func_mex_model, D, utility  )

p = [ theta  ones(1,length(utility.pNames) - length(theta))    ] ;

%% USING ARBITARAY VALUES FOR SS - ASSUMING NO CHANGE DURING INTERVENTION
EI = 3115;% kcal per day;
p( ismember(utility.pNames,'EI0')) = EI; % Energy intake before dietary intervention
p( ismember(utility.pNames,'EI'))  = EI; % Energy intake before dietary intervention % <-- used for steady-state simulation EI/EI0 = 1

p( ismember(utility.pNames, 'cf' ))   = 0.4;  % Diet carbohydrate fraction before intervention % <-- used for steady-state simulation ff/f0 = 1
p( ismember(utility.pNames, 'ff' ))   = 0.42; % Diet fat fraction before intervention

p( ismember(utility.pNames, 'cf0' ))  = 0.4; 
p( ismember(utility.pNames, 'ff0' ))  = 0.42; 

ic = utility.ic0 ;

%% Simulation

pss =p; 
pss( ismember(utility.pNames, 'pxACC' ))  = 0; 
s_b = func_mex_model(0:1:1000,[],pss); ic1 = s_b.statevalues(end,:);

% Intervention

p( ismember(utility.pNames, 'pxACC' ))  = 1;  % Drug intervention  ! No change in diet. 

if nargin > 4
t  = 0:0.01:D.Lawitz2018.LF.Time(end); 
else
t  = 0:0.1:D.Lawitz2018.LF.Time(end); 
end


s_d = func_mex_model(t , ic1, p);


