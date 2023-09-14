
load('../../Results/Article figures/figure2/optESS(5.04)Best fit training data.mat'); 

theta = Results.xbest ;

%%
p = [ theta   utility.p0( find(strcmp('cf', utility.pNames)) :end )'       ] ;

p( ismember(utility.pNames, 'pxIR'  ))  = 0 ;

EI = 3115;% kcal per day;
p( ismember(utility.pNames,'EI0')) = EI; % Before dietary intervention
p( ismember(utility.pNames,'EI'))  = EI;

p( ismember(utility.pNames, 'cf' ))   = 0.4;
p( ismember(utility.pNames, 'ff' ))   = 0.42;

p( ismember(utility.pNames, 'cf0' ))  = 0.4;
p( ismember(utility.pNames, 'ff0' ))  = 0.42;

sim_time = 0:10:(365)*10 ;

%% NAFLD - HIGH (~18% )
p_high = p;

ic = ic0;

p_high(ismember(utility.pNames, 'EIrestriction2'  )) =  0 ;

F = 40;

ic( ismember(SBstates(objModel), 'F'  ))  = F ;

p_high(ismember(utility.pNames, 'Finit'  )) =  F ;

p_high(ismember(utility.pNames, 'BWinit'  )) =  65 + F ;

s_s_high  = func_mex_model( 0:10 , ic , p_high ) ;

p_high(ismember(utility.pNames, 'kIR'  )) = 1.2;

p_high(ismember(utility.pNames, 'EIrestriction2'  )) =  -400 ;

s_d_high  = func_mex_model( sim_time , s_s_high.statevalues(end, :) , p_high ) ;


f1 = figure(1) ;

f1.Position = [0 0 1200 400];


subplot(1,3,1)

bw_col = [ 0.5 0.5 0.5];
f_col = [ 0.5 0.6 0.7];

plot(s_d_high.time./365, s_d_high.variablevalues(:,ismember(s_d_high.variables, 'BW')) ,'color' , bw_col , 'LineWidth', 1.5 )
hold on
plot(s_d_high.time./365, s_d_high.statevalues(:,ismember(s_d_high.states, 'F')) ,'color' , f_col , 'LineWidth', 1.5 )

ylabel('Mass (kg)')
xlabel(' Time (Years)');

legend({'Bodyweight', 'Fat mass'})
set(gca,'fontsize' , 16);

yticks([ 0 60 120]); 

box 'off'

subplot(1,3,2)
plot(s_d_high.time./365, s_d_high.variablevalues(:,ismember(s_d_high.variables, 'ff2')) ,'color' , [ 0 0 0 ] , 'LineWidth', 1.5 )
hold on
plot(s_d_high.time./365, 5*ones(1,length(s_d_high.time)) , '--' ,'color' , [ 0 0 0 ] , 'LineWidth', 0.25 )



ylabel('^1H-MRS PDFF (%)') ; yticks([ 0 10 20]); ylim([0 20])
xlabel(' Time (Years)');

set(gca,'fontsize' , 16);

box 'off'

subplot(1,3,3)


nefa_col = [ 0 1 0.5];
tg_col   = [ 0 0.5 0.5];
dnl_col  = [ 0 0.7 0.3];


plot(s_d_high.time./365, s_d_high.variablevalues(:,ismember(s_d_high.variables, 'vAdipose_NEFA')) ,'color' , nefa_col , 'LineWidth', 1.5 )
hold on
plot(s_d_high.time./365, s_d_high.variablevalues(:,ismember(s_d_high.variables, 'vDietary_TG')) ,'color' , tg_col , 'LineWidth', 1.5 )
plot(s_d_high.time./365, s_d_high.variablevalues(:,ismember(s_d_high.variables, 'vDNL')),'color' , dnl_col , 'LineWidth', 1.5  )

ylabel('Influx (mg/g)(s^-1)') ; yticks([ 0 30 60]); 
xlabel(' Time (Years)');


legend({'NEFA','Dietary TG', 'DNL'})
set(gca,'fontsize' , 16);


box 'off' 

set(gcf, 'color' , 'w')

%% Healthy 

p_healthy = p;

ic = ic0;

p_healthy(ismember(utility.pNames, 'EIrestriction2'  )) =  0 ;

F = 19;

ic( ismember(SBstates(objModel), 'F'  ))  = F ;

p_healthy(ismember(utility.pNames, 'Finit'  )) =  F ;

p_healthy(ismember(utility.pNames, 'BWinit'  )) =  65 + F ;


p_healthy(ismember(utility.pNames, 'kTCA'  )) =  p_healthy(ismember(utility.pNames, 'kTCA'  ))*0.2; 
p_healthy(ismember(utility.pNames, 'kNEFAuptakeH'  )) = p_healthy(ismember(utility.pNames, 'kNEFAuptakeH'  ))*0.2;


s_s_healthy  = func_mex_model( 0:10 , ic , p_healthy ) ;

p_healthy(ismember(utility.pNames, 'kIR'  )) = 1.2;

p_healthy(ismember(utility.pNames, 'EIrestriction2'  )) =  400 ;

s_d_healthy  = func_mex_model( sim_time , s_s_healthy.statevalues(end, :) , p_healthy ) ;



f2 = figure(2) ;

f2.Position = [0 0 1200 400];

subplot(1,3,1)
plot(s_d_healthy.time./365, s_d_healthy.variablevalues(:,ismember(s_d_healthy.variables, 'BW')) , 'color', bw_col , 'LineWidth', 1.5 )
hold on
plot(s_d_healthy.time./365, s_d_healthy.statevalues(:,ismember(s_d_healthy.states, 'F')) ,'color', f_col , 'LineWidth', 1.5 )

ylabel('Mass (kg)')
xlabel(' Time (Years)');

legend({'Bodyweight', 'Fat mass'})
set(gca,'fontsize' , 16);

yticks([ 0 60 120]); 


box 'off'

subplot(1,3,2)
plot(s_d_healthy.time./365, s_d_healthy.variablevalues(:,ismember(s_d_healthy.variables, 'ff2')) ,'color', [ 0 0 0 ] , 'LineWidth', 1.5)
hold on
plot(s_d_high.time./365, 5*ones(1,length(s_d_high.time)) , '--' ,'color' , [ 0 0 0 ] , 'LineWidth', 0.25 )

ylabel('^1H-MRS PDFF (%)') ; yticks([ 0 10 20]); ylim([0 20])
xlabel(' Time (Years)');

set(gca,'fontsize' , 16);

box 'off'

subplot(1,3,3)
plot(s_d_healthy.time./365, s_d_healthy.variablevalues(:,ismember(s_d_healthy.variables, 'vAdipose_NEFA')) ,'color' , nefa_col , 'LineWidth', 1.5 )
hold on
plot(s_d_healthy.time./365, s_d_healthy.variablevalues(:,ismember(s_d_healthy.variables, 'vDietary_TG')) ,'color' , tg_col , 'LineWidth', 1.5)
plot(s_d_healthy.time./365, s_d_healthy.variablevalues(:,ismember(s_d_healthy.variables, 'vDNL')) ,'color' , dnl_col , 'LineWidth', 1.5)


ylabel('Influx (mg/g)(s^-1)') ; yticks([ 0 30 60]); 
xlabel(' Time (Years)');

legend({'NEFA','Dietary TG', 'DNL'})
set(gca,'fontsize' , 16);

box 'off'


set(gcf, 'color' , 'w')

