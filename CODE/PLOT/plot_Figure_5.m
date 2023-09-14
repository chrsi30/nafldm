%% 
dir_parameter_files = '../../Results/Article figures/figure2/Sampled/';
files =  dir ( fullfile(  [ dir_parameter_files,'*.mat']) );

load('../../Results/Article figures/figure2/optESS(5.04)Best fit training data.mat'); objf = Results.fbest; % lowest objectuve function value 
limit_main_pool = objf + chi2inv(0.95,  1  ) ; % Uncertainty cut-off

c = 0;
for kk = 1:size( files ,1)


       disp(['running throught - ' files(kk).name  ])
       load( [dir_parameter_files files(kk).name ])

        S =   parameters.S.par(:,1:1:end)  ;

    for jj = 1:size(S,2)

            theta =  ( S(:,jj) );

            cost =  fobj_ESS( theta ,func_mex_model, D, utility ,0  ) ;

        if cost < limit_main_pool
            c = c +1;

            [s_d]  = tmp_sim( theta ,func_mex_model, D, utility) ;


            for k = 1:25
                clear tmp;
                tmp = s_d.(['Diet' int2str(k) ]);
                tmp2(k,:) =  tmp.variablevalues(end,ismember(SBvariables(objModel), 'vDNL' ))/tmp.variablevalues(end,ismember(SBvariables(objModel), 'vTOTAL_FAT_FLUX' ) ) ;
                tmp3(k,:) =  tmp.variablevalues(end,ismember(SBvariables(objModel), 'vBOX' ))/tmp.variablevalues(end,ismember(SBvariables(objModel), 'vTOTAL_FAT_FLUX_EFFLUX' ) ) ;
                tmp4(k,:) =  tmp.variablevalues(end,ismember(SBvariables(objModel), 'ff2' ));
            end

            theta2 = theta;
            theta2(ismember(utility.pNames, 'kTCA' ))  = theta2( ismember(utility.pNames, 'kTCA' ) )*0.05;

            [s_d2]  = tmp_sim( theta2 ,func_mex_model, D, utility) ;

            for u = 1:25
                clear tmpx;

                tmpx = s_d2.(['Diet' int2str(u) ]);
                tmp5(u,:) =  tmpx.variablevalues(end,ismember(SBvariables(objModel), 'vDNL' ))/tmpx.variablevalues(end,ismember(SBvariables(objModel), 'vTOTAL_FAT_FLUX' ) ) ;
                tmp6(u,:) =  tmpx.variablevalues(end,ismember(SBvariables(objModel), 'vBOX' ))/tmpx.variablevalues(end,ismember(SBvariables(objModel), 'vTOTAL_FAT_FLUX_EFFLUX' ) ) ;
                tmp7(u,:) =  tmpx.variablevalues(end,ismember(SBvariables(objModel), 'ff2' ));

            end

%%%
            
            if sum(theta < 0 ) > 1
                theta3 = exp(theta)' ;
            end
            
            p = parameter_sorting(theta3, utility,flag) ;

            p = [ p.main  ones(1,length(utility.pNames) - length(p.main))    ] ;


            EI = 3115;% kcal per day;
            p( ismember(utility.pNames,'EI0')) = EI; % Before dietary intervention
            p( ismember(utility.pNames,'EI'))  = EI;

            p( ismember(utility.pNames, 'cf' ))   = 0.4;
            p( ismember(utility.pNames, 'ff' ))   = 0.42;

            p( ismember(utility.pNames, 'cf0' ))  = 0.4;
            p( ismember(utility.pNames, 'ff0' ))  = 0.42;
       
            pss =p;
            s_b = func_mex_model(0:100:1000,[],pss); ic1 = s_b.statevalues(end,:);


            %%% 1
            p( ismember(utility.pNames, 'cf' ))  = 0.7 - 0.0275*25;
            p( ismember(utility.pNames, 'ff' ))  = 0.16 +  0.0275*25;

             s_dx = func_mex_model( 0:0.1:14 , ic1, p);

            LFdyn  =  s_dx.variablevalues( : , ismember( SBvariables( objModel), 'ff2'  ));

            %%% 2
            p( ismember(utility.pNames, 'cf' ))  = 0.7 - 0.0275*1;
            p( ismember(utility.pNames, 'ff' ))  = 0.16 +  0.0275*1;

             s_dx2 = func_mex_model( 0:0.1:14 , ic1, p);

            LFdyn2  =  s_dx2.variablevalues( : , ismember( SBvariables( objModel), 'ff2'  ));




            if c == 1

                UNC.DNL_ratio.min = tmp2;                 UNC.DNL_ratio.max = tmp2;
                UNC.BOX_ratio.min = tmp3;                 UNC.BOX_ratio.max = tmp3;
                UNC.LF.min = tmp4;                        UNC.LF.max = tmp4;


                UNC.DNL_ratio2.min = tmp5;                 UNC.DNL_ratio2.max = tmp5;
                UNC.BOX_ratio2.min = tmp6;                 UNC.BOX_ratio2.max = tmp6;
                UNC.LF2.min = tmp7;                        UNC.LF2.max = tmp7;

                UNC.LFdyn.max  = LFdyn ;  UNC.LFdyn.min = LFdyn;
                UNC.LFdyn2.max  = LFdyn2 ;  UNC.LFdyn2.min = LFdyn2;


                b_c.cost = cost;
                b_c.vvar.DNL = tmp2;
                b_c.vvar.BOX = tmp3;
                b_c.vvar.LF  = tmp4;

                b_c.vvar.DNL2 = tmp5;
                b_c.vvar.BOX2 = tmp6;
                b_c.vvar.LF2  = tmp7;

                b_c.vvar.LFdyn = LFdyn;
                b_c.vvar.LFdyn2 = LFdyn2;


            end

            [UNC.DNL_ratio.max  , UNC.DNL_ratio.min  ] =  calc_min_max( UNC.DNL_ratio.max ,UNC.DNL_ratio.min , tmp2 ) ;

            [UNC.BOX_ratio.max  , UNC.BOX_ratio.min  ] =  calc_min_max( UNC.BOX_ratio.max ,UNC.BOX_ratio.min , tmp3 ) ;

            [UNC.LF.max  , UNC.LF.min  ] =  calc_min_max( UNC.LF.max ,UNC.LF.min , tmp4 ) ;


            [UNC.DNL_ratio2.max  , UNC.DNL_ratio2.min  ] =  calc_min_max( UNC.DNL_ratio2.max ,UNC.DNL_ratio2.min , tmp5 ) ;

            [UNC.BOX_ratio2.max  , UNC.BOX_ratio2.min  ] =  calc_min_max( UNC.BOX_ratio2.max ,UNC.BOX_ratio2.min , tmp6 ) ;

            [UNC.LF2.max  , UNC.LF2.min  ] =  calc_min_max( UNC.LF2.max ,UNC.LF2.min , tmp7 ) ;

%%%
            [UNC.LFdyn.max  , UNC.LFdyn.min ] =  calc_min_max( UNC.LFdyn.max ,UNC.LFdyn.min, LFdyn ) ;
            [UNC.LFdyn2.max  , UNC.LFdyn2.min ] =  calc_min_max( UNC.LFdyn2.max ,UNC.LFdyn2.min, LFdyn2 ) ;


            if cost < b_c.cost
                b_c.cost = cost;
                b_c.vvar.DNL = tmp2;
                b_c.vvar.BOX = tmp3;
                b_c.vvar.LF = tmp4;

                b_c.vvar.DNL2 = tmp5;
                b_c.vvar.BOX2 = tmp6;
                b_c.vvar.LF2 = tmp7;


                b_c.vvar.LFdyn = LFdyn;
                b_c.vvar.LFdyn2 = LFdyn2;


            end
        end
    end


end


%%%
%%
line_size_sim = 2 ;
line_size_data = 1.5 ;
marker_size    = 8;

col = [0.8 0.2 0.8]; 
col_line = [0.8 0.2  0.8 ] ;

f1 = figure;

set(gcf, 'color' , 'w' ) ;

tiledlayout(2,3 ,'TileSpacing','loose');

set(gcf, 'color' , 'w') ;

nexttile(1)

t_d = s_dx.time;
t_f = [ t_d fliplr(t_d)];  % Time-vector for fill area


f = fill(t_f, [ UNC.LFdyn.max' fliplr( UNC.LFdyn.min' ) ], col,'Edgecolor', 'none');

set(f,'facealpha',.3)
hold on

plot ( t_d,  b_c.vvar.LFdyn , "color", col_line, 'LineWidth', line_size_sim );

xlim([0 14]); xticks([ 0 7 14]);
ylim([0 25]);

ylabel('^1H-MRS PDFF  (%)');
xlabel({' time (days)'}) ; 

box 'off' ;
    
set(gca, 'fontsize', 10);
%%%
nexttile(2)

t_d = s_dx.time;
t_f = [ t_d fliplr(t_d)];  % Time-vector for fill area


f = fill(t_f, [ UNC.LFdyn2.max' fliplr( UNC.LFdyn2.min' ) ], col,'Edgecolor', 'none');

set(f,'facealpha',.3)
hold on

plot ( t_d,  b_c.vvar.LFdyn2 , "color", col_line, 'LineWidth', line_size_sim );

xlim([0 14]); xticks([ 0 7 14]);
ylim([0 25]);

ylabel('^1H-MRS PDFF  (%)');
xlabel({' time (days)'}) ; 

box 'off' ;
    
set(gca, 'fontsize', 10);



%%%  HIGH NAFLD group

nexttile(4)

for kk = 1:25
cf = 0.7 - 0.0275*kk; 
ff  = 0.16 +  0.0275*kk; 
if kk == 1 
    cf0 = cf;
end
cf_c0(kk) = cf*100;  %/cf0 ;

end

for kk = 1:size(UNC.LF.min,1) 

tmp = [ cf_c0(kk)  UNC.LF.min(kk)    0.02*100  abs( (UNC.LF.max(kk) - UNC.LF.min(kk)) )  ] ;

rectangle('Position',tmp, 'FaceColor',col,'EdgeColor','none'); 
hold on
%plot( [cf_c0(kk)  (cf_c0(kk)+0.02*100) ]  , [ b_c.vvar.LF(kk) b_c.vvar.LF(kk) ] , 'color', col_line ,  'LineWidth', 1.5);

end
xlim([0 70]); xticks([0 10 20 30 40 50 60 70]);
ylim([0 25]);
ylabel({'End of intervention' ;'^1H-MRS PDFF  (%)'}) ; xlabel({' Fraction carbohydrates (%)'}) ; 
set(gca, 'fontsize', 10);


nexttile(5)

for kk = 1:25
cf = 0.7 - 0.0275*kk; 
ff  = 0.16 +  0.0275*kk; 
if kk == 1 
    cf0 = cf;
end
cf_c0(kk) = cf*100;  %/cf0 ;

end

for kk = 1:25

tmp = [ cf_c0(kk)  UNC.DNL_ratio.min(kk)*100    0.02*100  abs( (UNC.DNL_ratio.max(kk) - UNC.DNL_ratio.min(kk))*100 )  ] ;

rectangle('Position',tmp, 'FaceColor',col,'EdgeColor','none'); 
hold on
%plot( [cf_c0(kk)  (cf_c0(kk)+0.02*100) ]  , [ b_c.vvar.DNL(kk) b_c.vvar.DNL(kk) ].*100 , 'color', col_line , 'LineWidth', 1.5);
hold on
end
xlim([0 70]); xticks([0 10 20 30 40 50 60 70]);
ylim([0 50]);
ylabel({'End of intervention' ;'Part DNL (%) of total influx'}) ; xlabel({' Fraction carbohydrates (%)'}) ; 
set(gca, 'fontsize', 10);
xlim([0 75])


nexttile(6)

for kk = 1:25
cf = 0.7 - 0.0275*kk; 
ff  = 0.16 +  0.0275*kk; 
if kk == 1 
    cf0 = cf;
end
cf_c0(kk) = cf*100;  %/cf0 ;

end

for kk = 1:25

tmp = [ cf_c0(kk)  UNC.BOX_ratio.min(kk)*100    0.02*100  abs( (UNC.BOX_ratio.max(kk) - UNC.BOX_ratio.min(kk))*100 )  ] ;

rectangle('Position',tmp, 'FaceColor',col,'EdgeColor','none'); 
hold on
%plot( [cf_c0(kk)  (cf_c0(kk)+0.02*100) ]  , [ b_c.vvar.BOX(kk) b_c.vvar.BOX(kk) ].*100 , 'color', col_line ,  'LineWidth', 1.5);
hold on

end
xlim([0 70]); xticks([0 10 20 30 40 50 60 70]);
ylim([0 100]);
ylabel({'End of intervention' ;'Ratio \beta-Ox (%) vs. total efflux'}) ; xlabel({' Fraction carbohydrates (%)'}) ; 
set(gca, 'fontsize', 10);


set(gcf, 'Units', 'centimeters');
set(gcf,'position', [ 0  0 21 12])





%%
function [s_d]  = tmp_sim( theta ,func_mex_model, D, utility)

if sum(theta < 0 ) > 1
theta = exp(theta)' ;
end

p = parameter_sorting(theta, utility,flag) ;

p = [ p.main  ones(1,length(utility.pNames) - length(p.main))    ] ;

EI = 3115;% kcal per day;
p( ismember(utility.pNames,'EI0')) = EI; % Before dietary intervention
p( ismember(utility.pNames,'EI'))  = EI;

p( ismember(utility.pNames, 'cf' ))   = 0.4; 
p( ismember(utility.pNames, 'ff' ))   = 0.42; 

p( ismember(utility.pNames, 'cf0' ))  = 0.4; 
p( ismember(utility.pNames, 'ff0' ))  = 0.42; 

pss =p; 
s_b = func_mex_model(0:100:1000,[],pss); ic1 = s_b.statevalues(end,:);

for kk = 1:25

p( ismember(utility.pNames, 'cf' ))  = 0.7 - 0.0275*kk; 
p( ismember(utility.pNames, 'ff' ))  = 0.16 +  0.0275*kk; 

s_d.(['Diet' int2str(kk) ]) = func_mex_model( 0:0.1:14 , ic1, p);

end


end


%%
function [max1, min1] = calc_min_max( in_max,in_min, sim )
max1= in_max; min1 = in_min;
max1( max1 < sim ) =  sim( max1 < sim);
min1( min1 > sim ) =  sim( min1 > sim);
end
