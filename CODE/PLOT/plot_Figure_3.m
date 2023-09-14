clear all
close all
clc

warning 'off'

load('../../Results/Article figures/figure3/b_c_Figure_3.mat')
load('../../Results/Article figures/figure3/Figure_3_UNC.mat')
load('../../Results/Article figures/figure3/t_d_Figure_3.mat')

run('../../Data/Load_data.m')
%%







%% PLOT
%%
line_size_sim = 2 ;
line_size_data = 1.5 ;
marker_size    = 8;

col_fill_validation   = [0.8 0.2 0.8]; 
col_line_validation = [0.8 0.2  0.8 ] ;

f1 = figure;

f1.Position = [0 0 1000 1440];

set(gcf, 'color' , 'w' ) ;

tiledlayout(4,4 ,'TileSpacing','loose');
%

%%% %% LCHF studies
%%%  Luukkonen 2020 - LCHF
nexttile(1) 


title( {'Low carbohydrate high fat (LCHF)' ; 'Luukkonen {\itet al.} 2020'; 'Caloric restriction  -\Delta579 kcal' ; '62/5/28% (F/C/P)' } );    % use for title positioning
ax = gca;
ax.TitleHorizontalAlignment = 'left';

hold on 

tmp = 'Luukkonen_2020' ; var  = 'ff2' ;

 t_f = [ t_d.(tmp) fliplr(t_d.(tmp))];  % Time-vector for fill area

f = fill(t_f, [ UNC.(tmp).(var).max' fliplr( UNC.(tmp).(var).min' ) ], col_fill_validation,'Edgecolor', 'none');
set(f,'facealpha',.3)
hold on
plot ( t_d.(tmp),  b_c.(tmp).(var).vvar , "color", col_line_validation , 'LineWidth', line_size_sim );

data_string = 'Luukkonen2020' ; study_type = 'LCHF' ; 

errorbar( D.(data_string).(study_type).LF.Time(1) , D.(data_string).(study_type).LF.Mean(1)   , D.(data_string).(study_type).LF.SEM(1) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )
errorbar( D.(data_string).(study_type).LF.Time(2) , D.(data_string).(study_type).LF.Mean(2)   , D.(data_string).(study_type).LF.SEM(2) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', col_fill_validation, 'MarkerEdgeColor', [ 0 0 0] )

ylabel('^1H-MRS PDFF (%)') ; 
xlabel('time (days)');


box 'off'

nexttile(2) 
var  = 'yBOX' ;

 t_f = [ t_d.(tmp) fliplr(t_d.(tmp))];  % Time-vector for fill area

f = fill(t_f, [ UNC.(tmp).(var).max' fliplr( UNC.(tmp).(var).min' ) ], col_fill_validation,'Edgecolor', 'none');
set(f,'facealpha',.3)
hold on
plot ( t_d.(tmp),  b_c.(tmp).(var).vvar , "color", col_line_validation , 'LineWidth', line_size_sim );

data_string = 'Luukkonen2020' ; study_type = 'LCHF' ; 

baseline =  D.(data_string).(study_type).BHB.Mean(1);
errorbar( D.(data_string).(study_type).BHB.Time(1) , D.(data_string).(study_type).BHB.Mean(1)./baseline   , D.(data_string).(study_type).BHB.SEM(1)./baseline ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )
errorbar( D.(data_string).(study_type).BHB.Time(2) , D.(data_string).(study_type).BHB.Mean(2)./baseline   , D.(data_string).(study_type).BHB.SEM(2)./baseline ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', col_fill_validation, 'MarkerEdgeColor', [ 0 0 0] )

ylabel( {'\beta-hydroxybutyrate' ;' basline fold (a.u.)'}) ; 
xlabel('time (days)');

box 'off'

%%%  % Browning 2011 - LCHF
nexttile(3)
title( {'Low carbohydrate high fat (LCHF)' ; 'Browning {\itet al.} 2021'; 'Isocaloric  -\Delta0 kcal' ; '59/12.8/33%  (F/C/P)' } );    % use for title positioning
ax = gca;
ax.TitleHorizontalAlignment = 'left';


hold on 
tmp = 'Browning_2011' ; var  = 'ff2' ;

 t_f = [ t_d.(tmp) fliplr(t_d.(tmp))];  % Time-vector for fill area

f = fill(t_f, [ UNC.(tmp).(var).max' fliplr( UNC.(tmp).(var).min' ) ], col_fill_validation,'Edgecolor', 'none');
set(f,'facealpha',.3)
hold on
plot ( t_d.(tmp),  b_c.(tmp).(var).vvar , "color", col_line_validation , 'LineWidth', line_size_sim );

data_string = 'Browning2011' ; study_type = 'LCHF' ; 

errorbar( D.(data_string).(study_type).LF.Time(1) , D.(data_string).(study_type).LF.Mean(1)   , D.(data_string).(study_type).LF.SEM(1) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )
errorbar( D.(data_string).(study_type).LF.Time(2) , D.(data_string).(study_type).LF.Mean(2)   , D.(data_string).(study_type).LF.SEM(2) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', col_fill_validation, 'MarkerEdgeColor', [ 0 0 0] )

ylabel('^1H-MRS PDFF (%)') ; 
xlabel('time (days)');

xlim([0 14]);

box 'off'

%%%  % Holmer 2021 - LCHF
nexttile(4)
title( {'Low carbohydrate high fat (LCHF)' ; 'Holmer {\itet al.} 2021'; 'Caloric restriction  -\Delta184 kcal' ; '68/12.8/21.3%  (F/C/P)' } );    % use for title positioning
ax = gca;
ax.TitleHorizontalAlignment = 'left';


hold on
tmp = 'Holmer_2021' ; var  = 'ff2' ;

 t_f = [ t_d.(tmp) fliplr(t_d.(tmp))];  % Time-vector for fill area

f = fill(t_f, [ UNC.(tmp).(var).max' fliplr( UNC.(tmp).(var).min' ) ], col_fill_validation,'Edgecolor', 'none');
set(f,'facealpha',.3)
hold on
plot ( t_d.(tmp),  b_c.(tmp).(var).vvar , "color", col_line_validation , 'LineWidth', line_size_sim );

data_string = 'Holmer2021' ; study_type = 'LCHF' ; 

errorbar( D.(data_string).(study_type).LF.Time(1) , D.(data_string).(study_type).LF.Mean(1)   , D.(data_string).(study_type).LF.SEM(1) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )
errorbar( D.(data_string).(study_type).LF.Time(2) , D.(data_string).(study_type).LF.Mean(2)   , D.(data_string).(study_type).LF.SEM(2) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', col_fill_validation, 'MarkerEdgeColor', [ 0 0 0] )

ylabel('^1H-MRS PDFF (%)') ; 
xlabel('time (days)');


xlim([0 84]);

box 'off'


%%% %% HC  studies

%%% Johnston 2013 - ISO HC
nexttile(5)
title( {'High carbohydrate (HC) - Fructose' ; 'Johnston {\itet al.} 2013'; 'Isocaloric  -\Delta0 kcal' ; '32/52.8/14.3%  (F/C/P)' } );    % use for title positioning
ax = gca;
ax.TitleHorizontalAlignment = 'left';

hold on
tmp = 'Johnston_2013_HC_ISO_F' ; var  = 'ff2' ;

 t_f = [ t_d.(tmp) fliplr(t_d.(tmp))];  % Time-vector for fill area

f = fill(t_f, [ UNC.(tmp).(var).max' fliplr( UNC.(tmp).(var).min' ) ], col_fill_validation,'Edgecolor', 'none');
set(f,'facealpha',.3)
hold on
plot ( t_d.(tmp),  b_c.(tmp).(var).vvar , "color", col_line_validation , 'LineWidth', line_size_sim );

data_string = 'Johnston2013' ; study_type = 'HC_ISO_F' ; 

errorbar( D.(data_string).(study_type).LF.Time(1) , D.(data_string).(study_type).LF.Mean(1)   , D.(data_string).(study_type).LF.SEM(1) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )
errorbar( D.(data_string).(study_type).LF.Time(2) , D.(data_string).(study_type).LF.Mean(2)   , D.(data_string).(study_type).LF.SEM(2) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', col_fill_validation, 'MarkerEdgeColor', [ 0 0 0] )

ylabel('^1H-MRS PDFF (%)') ; 
xlabel('time (days)');

ylim([5 13]);
xlim([0 14]);

box 'off'


%%% Johnston 2013 - OF HC

nexttile(6)
title( {' ' ; 'Over feeding  +\Delta1000 kcal' ; '32/52.8/14.3%  (F/C/P)' } );    % use for title positioning
ax = gca;
ax.TitleHorizontalAlignment = 'left';

hold on
tmp = 'Johnston_2013_HC_OF_F' ; var  = 'ff2' ;

 t_f = [ t_d.(tmp) fliplr(t_d.(tmp))];  % Time-vector for fill area

f = fill(t_f, [ UNC.(tmp).(var).max' fliplr( UNC.(tmp).(var).min' ) ], col_fill_validation,'Edgecolor', 'none');
set(f,'facealpha',.3)
hold on
plot ( t_d.(tmp),  b_c.(tmp).(var).vvar , "color", col_line_validation , 'LineWidth', line_size_sim );

data_string = 'Johnston2013' ; study_type = 'HC_OF_F' ; 

errorbar( D.(data_string).(study_type).LF.Time(1) , D.(data_string).(study_type).LF.Mean(1)   , D.(data_string).(study_type).LF.SEM(1) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )
errorbar( D.(data_string).(study_type).LF.Time(2) , D.(data_string).(study_type).LF.Mean(2)   , D.(data_string).(study_type).LF.SEM(2) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', col_fill_validation, 'MarkerEdgeColor', [ 0 0 0] )

ylabel('^1H-MRS PDFF (%)') ; 
xlabel('time (days)');

ylim([5 13]);
xlim([0 14]);

box 'off'

%%%
nexttile(7)
title( {'High carbohydrate (HC) - Glucose' ; 'Luukkonen {\itet al.} 2018'; 'Over feeding  +\Delta943 kcal' ; '23.8/63.7/11.4%  (F/C/P)' } );    % use for title positioning
ax = gca;
ax.TitleHorizontalAlignment = 'left';

hold on
tmp = 'Luukkonen_2018_HCOF' ; var  = 'ff2' ;

 t_f = [ t_d.(tmp) fliplr(t_d.(tmp))];  % Time-vector for fill area

f = fill(t_f, [ UNC.(tmp).(var).max' fliplr( UNC.(tmp).(var).min' ) ], col_fill_validation,'Edgecolor', 'none');
set(f,'facealpha',.3)
hold on
plot ( t_d.(tmp),  b_c.(tmp).(var).vvar , "color", col_line_validation , 'LineWidth', line_size_sim );

data_string = 'Luukkonen2018' ; study_type = 'HCOF' ; 

errorbar( D.(data_string).(study_type).LF.Time(1) , D.(data_string).(study_type).LF.Mean(1)   , D.(data_string).(study_type).LF.SEM(1) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )
errorbar( D.(data_string).(study_type).LF.Time(2) , D.(data_string).(study_type).LF.Mean(2)   , D.(data_string).(study_type).LF.SEM(2) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', col_fill_validation, 'MarkerEdgeColor', [ 0 0 0] )

ylabel('^1H-MRS PDFF (%)') ; 
xlabel('time (days)');


xlim([0 21]);


box 'off'

%%%
nexttile(8)
tmp = 'Luukkonen_2018_HCOF' ; var  = 'yDNL' ;

 t_f = [ t_d.(tmp) fliplr(t_d.(tmp))];  % Time-vector for fill area

f = fill(t_f, [ UNC.(tmp).(var).max' fliplr( UNC.(tmp).(var).min' ) ], col_fill_validation,'Edgecolor', 'none');
set(f,'facealpha',.3)
hold on
plot ( t_d.(tmp),  b_c.(tmp).(var).vvar , "color", col_line_validation , 'LineWidth', line_size_sim );

data_string = 'Luukkonen2018' ; study_type = 'HCOF' ; 

baseline =  D.(data_string).(study_type).DNL.Mean(1);
errorbar( D.(data_string).(study_type).DNL.Time(1) , D.(data_string).(study_type).DNL.Mean(1)/baseline   , D.(data_string).(study_type).DNL.SEM(1)/baseline  ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )
errorbar( D.(data_string).(study_type).DNL.Time(2) , D.(data_string).(study_type).DNL.Mean(2)/baseline    , D.(data_string).(study_type).DNL.SEM(2)/baseline  ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', col_fill_validation, 'MarkerEdgeColor', [ 0 0 0] )

ylabel({'DNL in VLDL-TG' ; 'basline fold (a.u.)'}) ; 
xlabel('time (days)');

xlim([0 21]);

box 'off'

%%%
nexttile(9)
title( {'High carbohydrate (HC) - Fructose' ; 'Taskinen {\itet al.} 2017'; 'Isocaloric  +\Delta54 kcal' ; '31.6/48.7/15.7%  (F/C/P)' } );    % use for title positioning
ax = gca;
ax.TitleHorizontalAlignment = 'left';

hold on
tmp = 'Taskinen_2017' ; var  = 'ff2' ;

 t_f = [ t_d.(tmp) fliplr(t_d.(tmp))];  % Time-vector for fill area

f = fill(t_f, [ UNC.(tmp).(var).max' fliplr( UNC.(tmp).(var).min' ) ], col_fill_validation,'Edgecolor', 'none');
set(f,'facealpha',.3)
hold on
plot ( t_d.(tmp),  b_c.(tmp).(var).vvar , "color", col_line_validation , 'LineWidth', line_size_sim );

data_string = 'Taskinen2017' ; study_type = 'HC_F' ; 

errorbar( D.(data_string).(study_type).LF.Time(1) , D.(data_string).(study_type).LF.Mean(1)   , D.(data_string).(study_type).LF.SEM(1) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )
errorbar( D.(data_string).(study_type).LF.Time(2) , D.(data_string).(study_type).LF.Mean(2)   , D.(data_string).(study_type).LF.SEM(2) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', col_fill_validation, 'MarkerEdgeColor', [ 0 0 0] )

ylabel('^1H-MRS PDFF (%)') ; 
xlabel('time (days)');

xlim([0 84]);

box 'off'
%%%%
nexttile(10)
var  = 'yDNL' ;

 t_f = [ t_d.(tmp) fliplr(t_d.(tmp))];  % Time-vector for fill area

f = fill(t_f, [ UNC.(tmp).(var).max' fliplr( UNC.(tmp).(var).min' ) ], col_fill_validation,'Edgecolor', 'none');
set(f,'facealpha',.3)
hold on
plot ( t_d.(tmp),  b_c.(tmp).(var).vvar , "color", col_line_validation , 'LineWidth', line_size_sim );

baseline =  D.(data_string).(study_type).DNL.Mean(1);
errorbar( D.(data_string).(study_type).LF.Time(1) , D.(data_string).(study_type).DNL.Mean(1)/baseline   , D.(data_string).(study_type).DNL.SEM(1)/baseline  ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )
errorbar( D.(data_string).(study_type).LF.Time(2) , D.(data_string).(study_type).DNL.Mean(2)/baseline    , D.(data_string).(study_type).DNL.SEM(2)/baseline  ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', col_fill_validation, 'MarkerEdgeColor', [ 0 0 0] )

ylabel({'DNL in VLDL-TG' ; 'basline fold (a.u.)'}) ; 
xlabel('time (days)');

xlim([0 84]);

box 'off'

%%%
nexttile(11) 
var  = 'yBOX' ;

 t_f = [ t_d.(tmp) fliplr(t_d.(tmp))];  % Time-vector for fill area

f = fill(t_f, [ UNC.(tmp).(var).max' fliplr( UNC.(tmp).(var).min' ) ], col_fill_validation,'Edgecolor', 'none');
set(f,'facealpha',.3)
hold on
plot ( t_d.(tmp),  b_c.(tmp).(var).vvar , "color", col_line_validation , 'LineWidth', line_size_sim );

baseline =  D.(data_string).(study_type).BHB.Mean(1);
errorbar( D.(data_string).(study_type).BHB.Time(1) , D.(data_string).(study_type).BHB.Mean(1)./baseline   , D.(data_string).(study_type).BHB.SEM(1)./baseline ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )
errorbar( D.(data_string).(study_type).BHB.Time(2) , D.(data_string).(study_type).BHB.Mean(2)./baseline   , D.(data_string).(study_type).BHB.SEM(2)./baseline ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', col_fill_validation, 'MarkerEdgeColor', [ 0 0 0] )

ylabel( {'\beta-hydroxybutyrate' ;' basline fold (a.u.)'}) ; 
xlabel('time (days)');

xlim([0 84]);

box 'off'
%%%
nexttile(13)
title( {'High Fat (HF)' ; 'Luukkonen {\itet al.} 2018'; 'Over feeding  +\Delta969 kcal' ; '58.9/25.9/15%  (F/C/P)' } );    % use for title positioning
ax = gca;
ax.TitleHorizontalAlignment = 'left';

hold on
tmp = 'Luukkonen_2018_HFOF' ; var  = 'ff2' ;

 t_f = [ t_d.(tmp) fliplr(t_d.(tmp))];  % Time-vector for fill area

f = fill(t_f, [ UNC.(tmp).(var).max' fliplr( UNC.(tmp).(var).min' ) ], col_fill_validation,'Edgecolor', 'none');
set(f,'facealpha',.3)
hold on
plot ( t_d.(tmp),  b_c.(tmp).(var).vvar , "color", col_line_validation , 'LineWidth', line_size_sim );

data_string = 'Luukkonen2018' ; study_type = 'HF_SAT_OF' ; 

errorbar( D.(data_string).(study_type).LF.Time(1) , D.(data_string).(study_type).LF.Mean(1)   , D.(data_string).(study_type).LF.SEM(1) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )
errorbar( D.(data_string).(study_type).LF.Time(2) , D.(data_string).(study_type).LF.Mean(2)   , D.(data_string).(study_type).LF.SEM(2) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', col_fill_validation, 'MarkerEdgeColor', [ 0 0 0] )

ylabel('^1H-MRS PDFF (%)') ; 
xlabel('time (days)');

xlim([0 21]);

box 'off'

