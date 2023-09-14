clear all
close all
clc

warning 'off'

load('../../Results/Article figures/figure6/b_c_Figure_6.mat')
load('../../Results/Article figures/figure6/Figure_6_UNC.mat')
load('../../Results/Article figures/figure6/t_d_Figure_6.mat')

run('../../Data/Load_data.m')


%%
line_size_sim = 2 ;
line_size_data = 1.5 ;
marker_size    = 8;

col = [0.8 0.2 0.8]; 
col_line = [0.8 0.2  0.8 ] ;

%%
line_size_sim = 2 ;
line_size_data = 1.5 ;
marker_size    = 8;


f1 = figure();

tiledlayout(1,4,"TileSpacing",	"loose")

%%%
nexttile(1)

b = bar([  b_c.Lawitz2018.DNL_start b_c.Lawitz2018.DNL_end ]-100,'FaceColor','flat', 'EdgeColor',col);
set(b,'facealpha',.5)

b.CData(1,:) = col;
b.CData(2,:) = col;

ylim([-30 0]); yticks([-30 -15 0]); ylabel('Inhibition of DNL (%)')

xticklabels({'Baseline', '12 weeks'}) ; xtickangle(90);

set(gca, 'fontsize' , 10)

box off

%%%
nexttile(2)

t_f = [ t_d.Lawitz2018  fliplr((t_d.Lawitz2018 ))]./(7);  % Time-vector for fill area

f = fill(t_f, [ UNC.Lawitz2018.LF.max' fliplr( UNC.Lawitz2018.LF.min' ) ], col ,'Edgecolor', col);
set(f,'facealpha',.5)

hold on
plot ( t_d.Lawitz2018,  b_c.Lawitz2018.LF , "color", col_line , 'LineWidth', line_size_sim );

errorbar( D.Lawitz2018.LF.Time(1)./7 , D.Lawitz2018.LF.Mean(1)   , D.Lawitz2018.LF.SEM(1) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size ,  'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )
errorbar( D.Lawitz2018.LF.Time(2:end)./7 , D.Lawitz2018.LF.Mean(2:end)   , D.Lawitz2018.LF.SEM(2:end) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size ,  'MarkerFaceColor', col, 'MarkerEdgeColor', [ 0 0 0] )

ylabel('^1H-MRS PDFF  (%)' ) ; xlabel('Time (Weeks)')

ylim([ 5 25]); xlim([0 12]); xticks([0 12]);

set(gca, 'fontsize' , 10)

box 'off'

set(gcf,'color' , 'w')

%%%
nexttile(3)

b = bar([  b_c.Beysen2020.DNL_start b_c.Beysen2020.DNL_end ]-100,'FaceColor','flat', 'EdgeColor',col);
set(b,'facealpha',.5)

b.CData(1,:) = col;
b.CData(2,:) = col;

ylim([-30 0]); yticks([-30 -15 0]); ylabel('Inhibition of DNL (%)')

xticklabels({'Baseline', '12 weeks'}); xtickangle(90);

set(gca, 'fontsize' , 10)

box off


%%%
nexttile(4)
t_f = [ t_d.Beysen2020 fliplr((t_d.Beysen2020))]./(7);  % Time-vector for fill area

f = fill(t_f, [ UNC.Beysen2020.LF.max' fliplr( UNC.Beysen2020.LF.min' ) ], col ,'Edgecolor', col);
set(f,'facealpha',.5)

hold on

plot ( t_d.Beysen2020,  b_c.Beysen2020.LF , "color", col_line , 'LineWidth', line_size_sim );

errorbar( D.Beysen2020.FT_4101_3mg.LF.Time(1)./7 , D.Beysen2020.FT_4101_3mg.LF.Mean(1)   , D.Beysen2020.FT_4101_3mg.LF.SEM(1) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size ,  'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )
errorbar( D.Beysen2020.FT_4101_3mg.LF.Time(2:end)./7 , D.Beysen2020.FT_4101_3mg.LF.Mean(2:end)   , D.Beysen2020.FT_4101_3mg.LF.SEM(2:end) ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size ,  'MarkerFaceColor', col, 'MarkerEdgeColor', [ 0 0 0] )


scatter(   D.Beysen2020.FT_4101_3mg.LF.Time(1)./7 , D.Beysen2020.FT_4101_3mg.LF.Indivual_pts(1,:), 10 ,  'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0]   )
scatter(   D.Beysen2020.FT_4101_3mg.LF.Time(2:end)./7 , D.Beysen2020.FT_4101_3mg.LF.Indivual_pts(2:end,:), 10 ,  'MarkerFaceColor', col, 'MarkerEdgeColor', [ 0 0 0]   )

ylabel('^1H-MRS PDFF  (%)' ) ; xlabel('Time (Weeks)')

ylim([ 5 35]); xlim([0 12]); xticks([0 12]);

set(gca, 'fontsize' , 10)

box 'off'
% 
set(gcf,'color' , 'w')



set(gcf, 'Units', 'centimeters');
set(gcf,'position', [ 0  0 21 7])



%%






