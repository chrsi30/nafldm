

clear all
close all
clc

warning 'off'

load('../../Results/Article figures/figure4/b_c_Figure_4.mat')
load('../../Results/Article figures/figure4/Figure_4_UNC.mat')

run('../../Data/Load_data.m')


list_study_names = {'Marin_2018_co1', 'Luukkonen_2020',  'Luukkonen_2018_HCOF' ,  'Luukkonen_2018_HFOF' ,  'Johnston_2013_HC_ISO_F'  ,  'Johnston_2013_HC_OF_F'  ...
    , 'Holmer_2021' , 'Taskinen_2017'  ,  'Browning_2011' } ; 

%%
col_teal  = [21, 165, 153]./255; % teal
col_brown = [128, 105, 23]./255; % brown
col_grey  = [223, 224, 223]./255; % teal

%%
f1 = figure(1) ;

f1.Position = [0 0 2400 1200];


set(gcf, 'color' , 'w' ) ;

tiledlayout(2,2,'TileSpacing','loose');

study_type_list =  {'LCHF', 'LCHF',  'HC' ,  'HF' ,  'HC'  ,  'HC' ,  'LCHF' , 'HC'  ,  'LCHF' } ; 


c1 = 0; c2 = 0; c3 = 0;

col1_line = [ 0 0 0 ] ;
xlabel_string = [];
for i = 1: size(list_study_names,2)
    
    tmp2  = list_study_names{i} ;
    type   = study_type_list{i} ;

    if strcmp(type, 'LCHF')
        c3 = c3 + 1; 
        xlabel_string{c3} = tmp2;
        c1 = c1 +2;
        x_pos_bar1 = 0.8 + (c1-2)*2 ;
        x_pos_bar2 = 1.8 + (c1-2)*2 ;
 
%%%
        nexttile(1)
        hold on
        high = [1;  UNC.(tmp2).fold_DNL.max   ] ;
        low  = [1;  UNC.(tmp2).fold_DNL.min   ] ;
        b = bar( c1 ,[  1   b_c.(tmp2).fold_DNL    ],'FaceColor','flat','EdgeColor', [ 0 0 0]);
        b(1).CData = col_teal;
        b(2).CData = col_brown;

        set(gca,'XTick',[])
        ylim([ 0 1]);
        ylabel({'Baseline fold DNL (a.u.)'})
        yticks([0 0.2 0.4 0.6 0.8 1] )
        set(gca, 'fontsize', 10);

        

        nexttile(2)
        hold on
        high = [1;  UNC.(tmp2).fold_BOX.max   ] ;
        low  = [1;  UNC.(tmp2).fold_BOX.min   ] ;

        rectangle('Position',[ x_pos_bar1 low(1)   0.4  abs( high(1) - low(1) )  ], 'FaceColor',col_teal,'EdgeColor',[ 0 0 0]);
        hold on
        plot([x_pos_bar1 x_pos_bar1+0.4] , [1   1] , 'color', col_teal,  'LineWidth',4 ,'HandleVisibility', 'off')

        rectangle('Position',[ x_pos_bar2 low(2)   0.4  abs( high(2) - low(2) )  ], 'FaceColor',col_grey,'EdgeColor', [ 0 0 0] );
        plot([x_pos_bar2 x_pos_bar2+0.4], [b_c.(tmp2).fold_BOX  b_c.(tmp2).fold_BOX] , 'color', col_brown, 'LineWidth',4 ,'HandleVisibility', 'off')
           set(gca,'XTick',[])
        ylim([ 0 5]);
        ylabel({'Baseline fold  \beta-Ox (a.u.)'})
        yticks([ 0 1 2 3 4  5]);
        set(gca, 'fontsize', 10);
    end

end        
nexttile(1)
xticks([2.2 4.2 6.2 8.2])
xticklabels(string(xlabel_string));
nexttile(2)
xticks([1.4 5.4 9.4 13.4])
xticklabels(string(xlabel_string));

c1 = 0; c2 = 0; c3=0;


for i = 1: size(list_study_names,2)
    
    tmp2  = list_study_names{i} ;
    type   = study_type_list{i} ;

    if strcmp(type, 'HC')
        c3 = c3 + 1; 
        xlabel_string{c3} = tmp2;

        c1 = c1 +2;
        x_pos_bar1 = 0.8 + (c1-2)*2 ;
        x_pos_bar2 = 1.8 + (c1-2)*2 ;


%%%
        nexttile(3)
        hold on
        b = bar( c1 ,[  1   b_c.(tmp2).fold_DNL    ], 'FaceColor', 'flat' ,'EdgeColor', [ 0 0 0] );
        b(1).CData = col_teal;
        b(2).CData = col_brown;

        set(gca,'XTick',[])
        ylim([ 0 3]);
        ylabel({'Baseline fold DNL (a.u.)'})
        yticks([0 1 2 3] )
       set(gca, 'fontsize', 10);
     

%%%
        nexttile(4)
        hold on
        high = [1;  UNC.(tmp2).fold_BOX.max   ] ;
        low  = [1;  UNC.(tmp2).fold_BOX.min   ] ;

        rectangle('Position',[ x_pos_bar1 low(1)   0.4  abs( high(1) - low(1) )  ], 'FaceColor',col_teal,'EdgeColor',[ 0 0 0] );
        hold on
        plot([x_pos_bar1 x_pos_bar1+0.4] , [1   1] , 'color', col_teal,  'LineWidth',1.5 ,'HandleVisibility', 'off')

        rectangle('Position',[ x_pos_bar2 low(2)   0.4  abs( high(2) - low(2) )  ], 'FaceColor',col_grey,'EdgeColor',[ 0 0 0] );
        plot([x_pos_bar2 x_pos_bar2+0.4], [b_c.(tmp2).fold_BOX  b_c.(tmp2).fold_BOX] , 'color', col_brown, 'LineWidth',1.5 ,'HandleVisibility', 'off')
        set(gca,'XTick',[])
        ylim([ 0 1]);
        ylabel({'Baseline fold  \beta-Ox (a.u.)'})
        yticks([ 0 0.2 0.4 0.6 0.8  1 ]);
       set(gca, 'fontsize', 10);
     
    end



end  
nexttile(3)
xticks([2.2 4.2 6.2 8.2])
xticklabels(string(xlabel_string));
nexttile(4)
xticks([1.4 5.4 9.4 13.4])
xticklabels(string(xlabel_string));

c1 = 0; c2 = 0; c3=0;


set(gcf, 'Units', 'centimeters');
set(gcf,'position', [ 0  0 21 12])


%%
f2 = figure(2) ;
f2.Position = [0 0 2400 1200];

set(gcf, 'color' , 'w' ) ;

tiledlayout(2,2,'TileSpacing','loose');

study_type_list =  {'LCHF', 'LCHF',  'HC' ,  'HF' ,  'HC'  ,  'HC' ,  'LCHF' , 'HC'  ,  'LCHF' } ; 

c1 = 0; c2 = 0; c3=0;

col1_line = [ 0 0 0 ] ;

for i = 1: size(list_study_names,2)
    
    tmp2  = list_study_names{i} ;
    type   = study_type_list{i} ;

    if strcmp(type, 'LCHF')

        c3 = c3 + 1; 
        xlabel_string{c3} = tmp2;
        c1 = c1 +2;
        x_pos_bar1 = 0.8 + (c1-2)*2 ;
        x_pos_bar2 = 1.8 + (c1-2)*2 ;


        col1      = [ 1 1- 0.075*(c1/2)*0.5  1- 0.075*(c1/2)*0.5 ] ;
 
%%%
        nexttile(1)
        hold on
        high = [UNC.(tmp2).Baseline_ratio_DNL_flux.max ;  UNC.(tmp2).EOT_ratio_DNL_flux.max   ]*100  ;
        low  = [UNC.(tmp2).Baseline_ratio_DNL_flux.min ;  UNC.(tmp2).EOT_ratio_DNL_flux.min   ]*100  ;

        rectangle('Position',[ x_pos_bar1 low(1)   0.4  abs( high(1) - low(1) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0]);
        hold on

        plot([x_pos_bar1 x_pos_bar1+0.4] , [b_c.(tmp2).Baseline_ratio_DNL_flux b_c.(tmp2).Baseline_ratio_DNL_flux]*100 , 'color', col1_line, 'LineWidth',1.5 ,'HandleVisibility', 'off')

        rectangle('Position',[ x_pos_bar2 low(2)   0.4  abs( high(2) - low(2) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0] );
        plot([x_pos_bar2 x_pos_bar2+0.4]  , [b_c.(tmp2).EOT_ratio_DNL_flux b_c.(tmp2).EOT_ratio_DNL_flux]*100 , 'color', col1_line, 'LineWidth',1.5 ,'HandleVisibility', 'off')
        set(gca,'XTick',[])
        ylim([ 0 40]);
        ylabel({' Ratio DNL (%) vs. total influx'})
       set(gca, 'fontsize', 10);

%%%
     
        nexttile(2)

        hold on
        high = [UNC.(tmp2).Baseline_ratio_BOX_flux.max ;  UNC.(tmp2).EOT_ratio_BOX_flux.max   ]*100  ;
        low  = [UNC.(tmp2).Baseline_ratio_BOX_flux.min ;  UNC.(tmp2).EOT_ratio_BOX_flux.min   ]*100  ;

        rectangle('Position',[ x_pos_bar1 low(1)   0.4  abs( high(1) - low(1) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0] ,'HandleVisibility', 'off');
        hold on
        plot([x_pos_bar1 x_pos_bar1+0.4] , [b_c.(tmp2).Baseline_ratio_BOX_flux  b_c.(tmp2).Baseline_ratio_BOX_flux ]*100 , 'color', col1_line,  'LineWidth',1.5 ,'HandleVisibility', 'off')

        rectangle('Position',[ x_pos_bar2 low(2)   0.4  abs( high(2) - low(2) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0] ,'HandleVisibility', 'off');
        plot([x_pos_bar2 x_pos_bar2+0.4], [b_c.(tmp2).EOT_ratio_BOX_flux  b_c.(tmp2).EOT_ratio_BOX_flux] *100, 'color', col1_line, 'LineWidth',1.5 ,'HandleVisibility', 'off')
        set(gca,'XTick',[])
        ylim([ 0 80]);
        ylabel({' Ratio \beta-Ox (%) vs. total efflux'})
        yticks([ 0 20 40 60 80]);
       set(gca, 'fontsize', 10);


    end

end
nexttile(1)
xticks([1.4 5.4 9.4 13.4])
xticklabels(string(xlabel_string));
nexttile(2)
xticks([1.4 5.4 9.4 13.4])
xticklabels(string(xlabel_string));
c1 = 0; c2 = 0;  c3=0;


for i = 1: size(list_study_names,2)
    
    tmp2  = list_study_names{i} ;
    type   = study_type_list{i} ;

    if strcmp(type, 'HC')
        c3 = c3 + 1; 
        xlabel_string{c3} = tmp2;

        c1 = c1 +2;
        x_pos_bar1 = 0.8 + (c1-2)*2 ;
        x_pos_bar2 = 1.8 + (c1-2)*2 ;

        col1      = [ 0.8 - 0.15*(c1/2)*0.5 1 - 0.15*(c1/2)*0.5   1 - 0.15*(c1/2)*0.5  ] ;

%%%
        nexttile(3)
        hold on
        high = [UNC.(tmp2).Baseline_ratio_DNL_flux.max ;  UNC.(tmp2).EOT_ratio_DNL_flux.max   ]*100  ;
        low  = [UNC.(tmp2).Baseline_ratio_DNL_flux.min ;  UNC.(tmp2).EOT_ratio_DNL_flux.min   ]*100  ;

        rectangle('Position',[ x_pos_bar1 low(1)   0.4  abs( high(1) - low(1) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0] );
        hold on

        plot([x_pos_bar1 x_pos_bar1+0.4] , [b_c.(tmp2).Baseline_ratio_DNL_flux b_c.(tmp2).Baseline_ratio_DNL_flux]*100 , 'color', col1_line, 'LineWidth',1.5 ,'HandleVisibility', 'off')

        rectangle('Position',[ x_pos_bar2 low(2)   0.4  abs( high(2) - low(2) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0]  );
        plot([x_pos_bar2 x_pos_bar2+0.4]  , [b_c.(tmp2).EOT_ratio_DNL_flux b_c.(tmp2).EOT_ratio_DNL_flux]*100 , 'color', col1_line, 'LineWidth',1.5 ,'HandleVisibility', 'off')
        set(gca,'XTick',[])
        ylim([ 0 15]);
        ylabel({' Ratio DNL (%) vs. total influx'})
       set(gca, 'fontsize', 10);


%%%        
        nexttile(4)
        hold on
        high = [UNC.(tmp2).Baseline_ratio_BOX_flux.max ;  UNC.(tmp2).EOT_ratio_BOX_flux.max   ]*100  ;
        low  = [UNC.(tmp2).Baseline_ratio_BOX_flux.min ;  UNC.(tmp2).EOT_ratio_BOX_flux.min   ]*100  ;

        rectangle('Position',[ x_pos_bar1 low(1)   0.4  abs( high(1) - low(1) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0] ,'HandleVisibility', 'off');
        hold on
        plot([x_pos_bar1 x_pos_bar1+0.4] , [b_c.(tmp2).Baseline_ratio_BOX_flux  b_c.(tmp2).Baseline_ratio_BOX_flux ]*100 , 'color', col1_line,  'LineWidth',1.5 ,'HandleVisibility', 'off')

        rectangle('Position',[ x_pos_bar2 low(2)   0.4  abs( high(2) - low(2) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0]  ,'HandleVisibility', 'off');
        plot([x_pos_bar2 x_pos_bar2+0.4], [b_c.(tmp2).EOT_ratio_BOX_flux  b_c.(tmp2).EOT_ratio_BOX_flux] *100, 'color', col1_line, 'LineWidth',1.5 ,'HandleVisibility', 'off')
        set(gca,'XTick',[])
        ylim([ 0 80]);
        ylabel({' Ratio \beta-Ox (%) vs. total efflux'})
        yticks([ 0 20 40 60 80]);
       set(gca, 'fontsize', 10);

%%%

    end



end
nexttile(3)
xticks([1.4 5.4 9.4 13.4])
xticklabels(string(xlabel_string));
nexttile(4)
xticks([1.4 5.4 9.4 13.4])
xticklabels(string(xlabel_string));
c1 = 0; c2 = 0;  c3=0;

set(gcf, 'Units', 'centimeters');
set(gcf,'position', [ 0  0 21 12])




%%
% %%
% f2 = figure(2) ;
% 
% f2.Position = [0 0 2400 1200];
% 
% set(gcf, 'color' , 'w' ) ;
% 
% tiledlayout(2,4,'TileSpacing','loose');
% 
% study_type_list =  {'LCHF', 'LCHF',  'HC' ,  'HF' ,  'HC'  ,  'HC' ,  'LCHF' , 'HC'  ,  'LCHF' } ; 
% 
% c1 = 0; c2 = 0;
% 
% col1_line = [ 0 0 0 ] ;
% 
% for i = 1: size(list_study_names,2)
%     
%     tmp2  = list_study_names{i} ;
%     type   = study_type_list{i} ;
% 
%     if strcmp(type, 'LCHF')
% 
% 
%         c1 = c1 +2;
%         x_pos_bar1 = 0.8 + (c1-2)*2 ;
%         x_pos_bar2 = 1.8 + (c1-2)*2 ;
% 
% 
%         col1      = [ 1 1- 0.075*(c1/2)*0.5  1- 0.075*(c1/2)*0.5 ] ;
%  
% %%%
%         nexttile(1)
%         hold on
%         high = [UNC.(tmp2).Baseline_ratio_DNL_flux.max ;  UNC.(tmp2).EOT_ratio_DNL_flux.max   ]*100  ;
%         low  = [UNC.(tmp2).Baseline_ratio_DNL_flux.min ;  UNC.(tmp2).EOT_ratio_DNL_flux.min   ]*100  ;
% 
%         rectangle('Position',[ x_pos_bar1 low(1)   0.4  abs( high(1) - low(1) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0]);
%         hold on
% 
%         plot([x_pos_bar1 x_pos_bar1+0.4] , [b_c.(tmp2).Baseline_ratio_DNL_flux b_c.(tmp2).Baseline_ratio_DNL_flux]*100 , 'color', col1_line, 'LineWidth',1.5 ,'HandleVisibility', 'off')
% 
%         rectangle('Position',[ x_pos_bar2 low(2)   0.4  abs( high(2) - low(2) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0] );
%         plot([x_pos_bar2 x_pos_bar2+0.4]  , [b_c.(tmp2).EOT_ratio_DNL_flux b_c.(tmp2).EOT_ratio_DNL_flux]*100 , 'color', col1_line, 'LineWidth',1.5 ,'HandleVisibility', 'off')
%         set(gca,'XTick',[])
%         ylim([ 0 40]);
%         ylabel({' Ratio DNL (%) vs. total influx'})
%        set(gca, 'fontsize', 10);
% 
% %%%
%         nexttile(2)
%         hold on
%         high = [1;  UNC.(tmp2).fold_DNL.max   ] ;
%         low  = [1;  UNC.(tmp2).fold_DNL.min   ] ;
%         b = bar( c1 ,[  1   b_c.(tmp2).fold_DNL    ], 'FaceColor', col1 ,'EdgeColor', [ 0 0 0]);
%         set(gca,'XTick',[])
%         ylim([ 0 1]);
%         ylabel({'Baseline fold DNL (a.u.)'})
%         yticks([0 0.2 0.4 0.6 0.8 1] )
%        set(gca, 'fontsize', 10);
% 
%         nexttile(3)
% 
%         hold on
%         high = [UNC.(tmp2).Baseline_ratio_BOX_flux.max ;  UNC.(tmp2).EOT_ratio_BOX_flux.max   ]*100  ;
%         low  = [UNC.(tmp2).Baseline_ratio_BOX_flux.min ;  UNC.(tmp2).EOT_ratio_BOX_flux.min   ]*100  ;
% 
%         rectangle('Position',[ x_pos_bar1 low(1)   0.4  abs( high(1) - low(1) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0] ,'HandleVisibility', 'off');
%         hold on
%         plot([x_pos_bar1 x_pos_bar1+0.4] , [b_c.(tmp2).Baseline_ratio_BOX_flux  b_c.(tmp2).Baseline_ratio_BOX_flux ]*100 , 'color', col1_line,  'LineWidth',1.5 ,'HandleVisibility', 'off')
% 
%         rectangle('Position',[ x_pos_bar2 low(2)   0.4  abs( high(2) - low(2) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0] ,'HandleVisibility', 'off');
%         plot([x_pos_bar2 x_pos_bar2+0.4], [b_c.(tmp2).EOT_ratio_BOX_flux  b_c.(tmp2).EOT_ratio_BOX_flux] *100, 'color', col1_line, 'LineWidth',1.5 ,'HandleVisibility', 'off')
%         set(gca,'XTick',[])
%         ylim([ 0 80]);
%         ylabel({' Ratio \beta-Ox (%) vs. total efflux'})
%         yticks([ 0 20 40 60 80]);
%        set(gca, 'fontsize', 10);
% 
%         nexttile(4)
%         hold on
%         high = [1;  UNC.(tmp2).fold_BOX.max   ] ;
%         low  = [1;  UNC.(tmp2).fold_BOX.min   ] ;
% 
%         rectangle('Position',[ x_pos_bar1 low(1)   0.4  abs( high(1) - low(1) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0]);
%         hold on
%         plot([x_pos_bar1 x_pos_bar1+0.4] , [1   1] , 'color', col1_line,  'LineWidth',1.5 ,'HandleVisibility', 'off')
% 
%         rectangle('Position',[ x_pos_bar2 low(2)   0.4  abs( high(2) - low(2) )  ], 'FaceColor',col1,'EdgeColor', [ 0 0 0] );
%         plot([x_pos_bar2 x_pos_bar2+0.4], [b_c.(tmp2).fold_BOX  b_c.(tmp2).fold_BOX] , 'color', col1_line, 'LineWidth',1.5 ,'HandleVisibility', 'off')
%            set(gca,'XTick',[])
%         ylim([ 0 5]);
%         ylabel({'Baseline fold  \beta-Ox (a.u.)'})
%         yticks([ 0 1 2 3 4  5]);
%        set(gca, 'fontsize', 10);
% 
% 
% 
%     end
% 
% end
% 
% c1 = 0; c2 = 0; 
% 
% 
% for i = 1: size(list_study_names,2)
%     
%     tmp2  = list_study_names{i} ;
%     type   = study_type_list{i} ;
% 
%     if strcmp(type, 'HC')
% 
%         c1 = c1 +2;
%         x_pos_bar1 = 0.8 + (c1-2)*2 ;
%         x_pos_bar2 = 1.8 + (c1-2)*2 ;
% 
%         col1      = [ 0.8 - 0.15*(c1/2)*0.5 1 - 0.15*(c1/2)*0.5   1 - 0.15*(c1/2)*0.5  ] ;
% 
% %%%
%         nexttile(5)
%         hold on
%         high = [UNC.(tmp2).Baseline_ratio_DNL_flux.max ;  UNC.(tmp2).EOT_ratio_DNL_flux.max   ]*100  ;
%         low  = [UNC.(tmp2).Baseline_ratio_DNL_flux.min ;  UNC.(tmp2).EOT_ratio_DNL_flux.min   ]*100  ;
% 
%         rectangle('Position',[ x_pos_bar1 low(1)   0.4  abs( high(1) - low(1) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0] );
%         hold on
% 
%         plot([x_pos_bar1 x_pos_bar1+0.4] , [b_c.(tmp2).Baseline_ratio_DNL_flux b_c.(tmp2).Baseline_ratio_DNL_flux]*100 , 'color', col1_line, 'LineWidth',1.5 ,'HandleVisibility', 'off')
% 
%         rectangle('Position',[ x_pos_bar2 low(2)   0.4  abs( high(2) - low(2) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0]  );
%         plot([x_pos_bar2 x_pos_bar2+0.4]  , [b_c.(tmp2).EOT_ratio_DNL_flux b_c.(tmp2).EOT_ratio_DNL_flux]*100 , 'color', col1_line, 'LineWidth',1.5 ,'HandleVisibility', 'off')
%         set(gca,'XTick',[])
%         ylim([ 0 15]);
%         ylabel({' Ratio DNL (%) vs. total influx'})
%        set(gca, 'fontsize', 10);
% 
% 
% %%%
%         nexttile(6)
%         hold on
%         b = bar( c1 ,[  1   b_c.(tmp2).fold_DNL    ], 'FaceColor', col1 ,'EdgeColor', [ 0 0 0] );
%         set(gca,'XTick',[])
%         ylim([ 0 3]);
%         ylabel({'Baseline fold DNL (a.u.)'})
%         yticks([0 1 2 3] )
%        set(gca, 'fontsize', 10);
% 
% %%%        
%         nexttile(7)
%         hold on
%         high = [UNC.(tmp2).Baseline_ratio_BOX_flux.max ;  UNC.(tmp2).EOT_ratio_BOX_flux.max   ]*100  ;
%         low  = [UNC.(tmp2).Baseline_ratio_BOX_flux.min ;  UNC.(tmp2).EOT_ratio_BOX_flux.min   ]*100  ;
% 
%         rectangle('Position',[ x_pos_bar1 low(1)   0.4  abs( high(1) - low(1) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0] ,'HandleVisibility', 'off');
%         hold on
%         plot([x_pos_bar1 x_pos_bar1+0.4] , [b_c.(tmp2).Baseline_ratio_BOX_flux  b_c.(tmp2).Baseline_ratio_BOX_flux ]*100 , 'color', col1_line,  'LineWidth',1.5 ,'HandleVisibility', 'off')
% 
%         rectangle('Position',[ x_pos_bar2 low(2)   0.4  abs( high(2) - low(2) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0]  ,'HandleVisibility', 'off');
%         plot([x_pos_bar2 x_pos_bar2+0.4], [b_c.(tmp2).EOT_ratio_BOX_flux  b_c.(tmp2).EOT_ratio_BOX_flux] *100, 'color', col1_line, 'LineWidth',1.5 ,'HandleVisibility', 'off')
%         set(gca,'XTick',[])
%         ylim([ 0 80]);
%         ylabel({' Ratio \beta-Ox (%) vs. total efflux'})
%         yticks([ 0 20 40 60 80]);
%        set(gca, 'fontsize', 10);
% 
% %%%
%         nexttile(8)
%         hold on
%         high = [1;  UNC.(tmp2).fold_BOX.max   ] ;
%         low  = [1;  UNC.(tmp2).fold_BOX.min   ] ;
% 
%         rectangle('Position',[ x_pos_bar1 low(1)   0.4  abs( high(1) - low(1) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0] );
%         hold on
%         plot([x_pos_bar1 x_pos_bar1+0.4] , [1   1] , 'color', col1_line,  'LineWidth',1.5 ,'HandleVisibility', 'off')
% 
%         rectangle('Position',[ x_pos_bar2 low(2)   0.4  abs( high(2) - low(2) )  ], 'FaceColor',col1,'EdgeColor',[ 0 0 0] );
%         plot([x_pos_bar2 x_pos_bar2+0.4], [b_c.(tmp2).fold_BOX  b_c.(tmp2).fold_BOX] , 'color', col1_line, 'LineWidth',1.5 ,'HandleVisibility', 'off')
%         set(gca,'XTick',[])
%         ylim([ 0 1]);
%         ylabel({'Baseline fold  \beta-Ox (a.u.)'})
%         yticks([ 0 0.2 0.4 0.6 0.8  1 ]);
%        set(gca, 'fontsize', 10);
%      
%     end
% 
% 
% 
% end
%   
% set(gcf, 'Units', 'centimeters');
% set(gcf,'position', [ 0  0 21 12])
% 






%%
function [max1, min1] = calc_min_max( in_max,in_min, sim )
max1= in_max; min1 = in_min;
max1( max1 < sim ) =  sim( max1 < sim);
min1( min1 > sim ) =  sim( min1 > sim);
end