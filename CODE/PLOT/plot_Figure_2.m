%% 
dir_parameter_files = '../../Results/Article figures/figure2/Sampled/';
files =  dir ( fullfile(  [ dir_parameter_files,'*.mat']) );

load('../../Results/Article figures/figure2/optESS(5.04)Best fit training data.mat'); objf = Results.fbest; % lowest objectuve function value 
limit_main_pool = objf + chi2inv(0.95,  1  ) ; % Uncertainty cut-off

if ~isempty( files )
    c = 0;
    for kk = 1:size( files ,1)
        disp(['Processing - ' files(kk).name  ])
        load( [dir_parameter_files files(kk).name ])
        S =   parameters.S.par(:,1:1:end)  ;
        for jj = 1:size(S,2)

            theta =  ( S(:,jj) );
            cost =  fobj_ESS( theta ,func_mex_model, D, utility ,0  ) ;

            if cost < limit_main_pool
                c = c + 1;
                %% Simulation
                if sum(theta < 0 ) > 1
                    theta = exp(theta)' ;
                end
                p = parameter_sorting(theta, utility,flag) ;

                [ s_b, s_d ] = f_sim_Marin_2018_co1( p.main ,func_mex_model, D, utility ) ;

                %% RATIOS
                % Influx
                Baseline_TOTAL_FAT_FLUX = s_b.variablevalues(end, ismember(SBvariables(utility.objModel),'vTOTAL_FAT_FLUX')) ;
                Baseline_DNL_flux       = s_b.variablevalues(end, ismember(SBvariables(utility.objModel),'vDNL')) ;
                Baseline_AT_FA_flux     = s_b.variablevalues(end, ismember(SBvariables(utility.objModel),'vAdipose_NEFA')) ;
                Baseline_Diet_FA_flux   = s_b.variablevalues(end, ismember(SBvariables(utility.objModel),'vDietary_TG')) ;

                Baseline_ratio_DNL_flux      =   Baseline_DNL_flux/Baseline_TOTAL_FAT_FLUX ;
                Baseline_ratio_AT_FA_flux    =   Baseline_AT_FA_flux/Baseline_TOTAL_FAT_FLUX ;
                Baseline_ratio_Diet_FA_flux  =   Baseline_Diet_FA_flux/Baseline_TOTAL_FAT_FLUX ;

                EOT_TOTAL_FAT_FLUX = s_d.variablevalues(end, ismember(SBvariables(utility.objModel),'vTOTAL_FAT_FLUX')) ;
                EOT_DNL_flux       = s_d.variablevalues(end, ismember(SBvariables(utility.objModel),'vDNL')) ;
                EOT_AT_FA_flux     = s_d.variablevalues(end, ismember(SBvariables(utility.objModel),'vAdipose_NEFA')) ;
                EOT_Diet_FA_flux   = s_d.variablevalues(end, ismember(SBvariables(utility.objModel),'vDietary_TG')) ;

                EOT_ratio_DNL_flux      =   EOT_DNL_flux/EOT_TOTAL_FAT_FLUX ;
                EOT_ratio_AT_FA_flux    =   EOT_AT_FA_flux/EOT_TOTAL_FAT_FLUX ;
                EOT_ratio_Diet_FA_flux  =   EOT_Diet_FA_flux/EOT_TOTAL_FAT_FLUX ;

                % Efflux
                Baseline_TOTAL_FAT_FLUX_EFFLUX  = s_b.variablevalues(end, ismember(SBvariables(utility.objModel),'vTOTAL_FAT_FLUX_EFFLUX')) ;
                Baseline_VLDL_flux              = s_b.variablevalues(end, ismember(SBvariables(utility.objModel),'vVLDLsec')) ;
                Baseline_BOX_flux               = s_b.variablevalues(end, ismember(SBvariables(utility.objModel),'vBOX')) ;

                Baseline_ratio_VLDL_flux       =   Baseline_VLDL_flux/Baseline_TOTAL_FAT_FLUX_EFFLUX ;
                Baseline_ratio_BOX_flux        =   Baseline_BOX_flux/Baseline_TOTAL_FAT_FLUX_EFFLUX ;

                EOT_TOTAL_FAT_FLUX_EFFLUX  = s_d.variablevalues(end, ismember(SBvariables(utility.objModel),'vTOTAL_FAT_FLUX_EFFLUX')) ;
                EOT_VLDL_flux              = s_d.variablevalues(end, ismember(SBvariables(utility.objModel),'vVLDLsec')) ;
                EOT_BOX_flux               = s_d.variablevalues(end, ismember(SBvariables(utility.objModel),'vBOX')) ;

                EOT_ratio_VLDL_flux       =   EOT_VLDL_flux/EOT_TOTAL_FAT_FLUX_EFFLUX ;
                EOT_ratio_BOX_flux        =   EOT_BOX_flux/EOT_TOTAL_FAT_FLUX_EFFLUX ;


                if c == 1
                    UNC.Baseline_TOTAL_FAT_FLUX.max  = Baseline_TOTAL_FAT_FLUX;  UNC.Baseline_TOTAL_FAT_FLUX.min  = Baseline_TOTAL_FAT_FLUX;
                    UNC.Baseline_DNL_flux.max  = Baseline_DNL_flux;  UNC.Baseline_DNL_flux.min  = Baseline_DNL_flux;
                    UNC.Baseline_AT_FA_flux.max  = Baseline_AT_FA_flux;  UNC.Baseline_AT_FA_flux.min  = Baseline_AT_FA_flux;
                    UNC.Baseline_Diet_FA_flux.max  = Baseline_Diet_FA_flux;  UNC.Baseline_Diet_FA_flux.min  = Baseline_Diet_FA_flux;

                    UNC.Baseline_ratio_DNL_flux.max  = Baseline_ratio_DNL_flux;  UNC.Baseline_ratio_DNL_flux.min  = Baseline_ratio_DNL_flux;
                    UNC.Baseline_ratio_AT_FA_flux.max  = Baseline_ratio_AT_FA_flux;  UNC.Baseline_ratio_AT_FA_flux.min  = Baseline_ratio_AT_FA_flux;
                    UNC.Baseline_ratio_Diet_FA_flux.max  = Baseline_ratio_Diet_FA_flux;  UNC.Baseline_ratio_Diet_FA_flux.min  = Baseline_ratio_Diet_FA_flux;

                    UNC.EOT_TOTAL_FAT_FLUX.max  = EOT_TOTAL_FAT_FLUX;  UNC.EOT_TOTAL_FAT_FLUX.min  = EOT_TOTAL_FAT_FLUX;
                    UNC.EOT_DNL_flux.max  = EOT_DNL_flux;  UNC.EOT_DNL_flux.min  = EOT_DNL_flux;
                    UNC.EOT_AT_FA_flux.max  = EOT_AT_FA_flux;  UNC.EOT_AT_FA_flux.min  = EOT_AT_FA_flux;
                    UNC.EOT_Diet_FA_flux.max  = EOT_Diet_FA_flux;  UNC.EOT_Diet_FA_flux.min  = EOT_Diet_FA_flux;

                    UNC.EOT_ratio_DNL_flux.max  = EOT_ratio_DNL_flux;  UNC.EOT_ratio_DNL_flux.min  = EOT_ratio_DNL_flux;
                    UNC.EOT_ratio_AT_FA_flux.max  = EOT_ratio_AT_FA_flux;  UNC.EOT_ratio_AT_FA_flux.min  = EOT_ratio_AT_FA_flux;
                    UNC.EOT_ratio_Diet_FA_flux.max  = EOT_ratio_Diet_FA_flux;  UNC.EOT_ratio_Diet_FA_flux.min  = EOT_ratio_Diet_FA_flux;

                    UNC.Baseline_TOTAL_FAT_FLUX_EFFLUX.max  = Baseline_TOTAL_FAT_FLUX_EFFLUX;  UNC.Baseline_TOTAL_FAT_FLUX_EFFLUX.min  = Baseline_TOTAL_FAT_FLUX_EFFLUX;
                    UNC.Baseline_VLDL_flux.max  = Baseline_VLDL_flux;  UNC.Baseline_VLDL_flux.min  = Baseline_VLDL_flux;
                    UNC.Baseline_BOX_flux.max  = Baseline_BOX_flux;  UNC.Baseline_BOX_flux.min  = Baseline_BOX_flux;

                    UNC.Baseline_ratio_VLDL_flux.max  = Baseline_ratio_VLDL_flux;  UNC.Baseline_ratio_VLDL_flux.min  = Baseline_ratio_VLDL_flux;
                    UNC.Baseline_ratio_BOX_flux.max  = Baseline_ratio_BOX_flux;  UNC.Baseline_ratio_BOX_flux.min  = Baseline_ratio_BOX_flux;


                    UNC.EOT_TOTAL_FAT_FLUX_EFFLUX.max  = EOT_TOTAL_FAT_FLUX_EFFLUX;  UNC.EOT_TOTAL_FAT_FLUX_EFFLUX.min  = EOT_TOTAL_FAT_FLUX_EFFLUX;
                    UNC.EOT_VLDL_flux.max  = EOT_VLDL_flux;  UNC.EOT_VLDL_flux.min  = EOT_VLDL_flux;
                    UNC.EOT_BOX_flux.max  = EOT_BOX_flux;  UNC.EOT_BOX_flux.min  = EOT_BOX_flux;

                    UNC.EOT_ratio_VLDL_flux.max  = EOT_ratio_VLDL_flux;  UNC.EOT_ratio_VLDL_flux.min  = EOT_ratio_VLDL_flux;
                    UNC.EOT_ratio_BOX_flux.max  = EOT_ratio_BOX_flux;  UNC.EOT_ratio_BOX_flux.min  = EOT_ratio_BOX_flux;

                end

                [UNC.Baseline_TOTAL_FAT_FLUX.max  , UNC.Baseline_TOTAL_FAT_FLUX.min ] =  calc_min_max( UNC.Baseline_TOTAL_FAT_FLUX.max ,UNC.Baseline_TOTAL_FAT_FLUX.min, Baseline_TOTAL_FAT_FLUX ) ;
                [UNC.Baseline_DNL_flux.max  , UNC.Baseline_DNL_flux.min ] =  calc_min_max( UNC.Baseline_DNL_flux.max ,UNC.Baseline_DNL_flux.min, Baseline_DNL_flux ) ;
                [UNC.Baseline_AT_FA_flux.max  , UNC.Baseline_AT_FA_flux.min ] =  calc_min_max( UNC.Baseline_AT_FA_flux.max ,UNC.Baseline_AT_FA_flux.min, Baseline_AT_FA_flux ) ;
                [UNC.Baseline_Diet_FA_flux.max  , UNC.Baseline_Diet_FA_flux.min ] =  calc_min_max( UNC.Baseline_Diet_FA_flux.max ,UNC.Baseline_Diet_FA_flux.min, Baseline_Diet_FA_flux ) ;
                [UNC.Baseline_ratio_DNL_flux.max  , UNC.Baseline_ratio_DNL_flux.min ] =  calc_min_max( UNC.Baseline_ratio_DNL_flux.max ,UNC.Baseline_ratio_DNL_flux.min, Baseline_ratio_DNL_flux ) ;
                [UNC.Baseline_ratio_AT_FA_flux.max  , UNC.Baseline_ratio_AT_FA_flux.min ] =  calc_min_max( UNC.Baseline_ratio_AT_FA_flux.max ,UNC.Baseline_ratio_AT_FA_flux.min, Baseline_ratio_AT_FA_flux ) ;
                [UNC.Baseline_ratio_Diet_FA_flux.max  , UNC.Baseline_ratio_Diet_FA_flux.min ] =  calc_min_max( UNC.Baseline_ratio_Diet_FA_flux.max ,UNC.Baseline_ratio_Diet_FA_flux.min, Baseline_ratio_Diet_FA_flux ) ;


                [UNC.EOT_TOTAL_FAT_FLUX.max  , UNC.EOT_TOTAL_FAT_FLUX.min ] =  calc_min_max( UNC.EOT_TOTAL_FAT_FLUX.max ,UNC.EOT_TOTAL_FAT_FLUX.min, EOT_TOTAL_FAT_FLUX ) ;
                [UNC.EOT_DNL_flux.max  , UNC.EOT_DNL_flux.min ] =  calc_min_max( UNC.EOT_DNL_flux.max ,UNC.EOT_DNL_flux.min, EOT_DNL_flux ) ;
                [UNC.EOT_AT_FA_flux.max  , UNC.EOT_AT_FA_flux.min ] =  calc_min_max( UNC.EOT_AT_FA_flux.max ,UNC.EOT_AT_FA_flux.min, EOT_AT_FA_flux ) ;
                [UNC.EOT_Diet_FA_flux.max  , UNC.EOT_Diet_FA_flux.min ] =  calc_min_max( UNC.EOT_Diet_FA_flux.max ,UNC.EOT_Diet_FA_flux.min, EOT_Diet_FA_flux ) ;
                [UNC.EOT_ratio_DNL_flux.max  , UNC.EOT_ratio_DNL_flux.min ] =  calc_min_max( UNC.EOT_ratio_DNL_flux.max ,UNC.EOT_ratio_DNL_flux.min, EOT_ratio_DNL_flux ) ;
                [UNC.EOT_ratio_AT_FA_flux.max  , UNC.EOT_ratio_AT_FA_flux.min ] =  calc_min_max( UNC.EOT_ratio_AT_FA_flux.max ,UNC.EOT_ratio_AT_FA_flux.min, EOT_ratio_AT_FA_flux ) ;
                [UNC.EOT_ratio_Diet_FA_flux.max  , UNC.EOT_ratio_Diet_FA_flux.min ] =  calc_min_max( UNC.EOT_ratio_Diet_FA_flux.max ,UNC.EOT_ratio_Diet_FA_flux.min, EOT_ratio_Diet_FA_flux ) ;


                [UNC.Baseline_TOTAL_FAT_FLUX_EFFLUX.max , UNC.Baseline_TOTAL_FAT_FLUX_EFFLUX.min ] =  calc_min_max( UNC.Baseline_TOTAL_FAT_FLUX_EFFLUX.max ,UNC.Baseline_TOTAL_FAT_FLUX_EFFLUX.min, Baseline_TOTAL_FAT_FLUX_EFFLUX ) ;
                [UNC.Baseline_VLDL_flux.max  , UNC.Baseline_VLDL_flux.min ] =  calc_min_max( UNC.Baseline_VLDL_flux.max ,UNC.Baseline_VLDL_flux.min, Baseline_VLDL_flux ) ;
                [UNC.Baseline_BOX_flux.max  , UNC.Baseline_BOX_flux.min ] =  calc_min_max( UNC.Baseline_BOX_flux.max ,UNC.Baseline_BOX_flux.min, Baseline_BOX_flux ) ;
                [UNC.Baseline_ratio_VLDL_flux.max  , UNC.Baseline_ratio_VLDL_flux.min ] =  calc_min_max( UNC.Baseline_ratio_VLDL_flux.max ,UNC.Baseline_ratio_VLDL_flux.min, Baseline_ratio_VLDL_flux ) ;
                [UNC.Baseline_ratio_BOX_flux.max  , UNC.Baseline_ratio_BOX_flux.min ] =  calc_min_max( UNC.Baseline_ratio_BOX_flux.max ,UNC.Baseline_ratio_BOX_flux.min, Baseline_ratio_BOX_flux ) ;


                [UNC.EOT_TOTAL_FAT_FLUX_EFFLUX.max , UNC.EOT_TOTAL_FAT_FLUX_EFFLUX.min ] =  calc_min_max( UNC.EOT_TOTAL_FAT_FLUX_EFFLUX.max ,UNC.EOT_TOTAL_FAT_FLUX_EFFLUX.min, EOT_TOTAL_FAT_FLUX_EFFLUX ) ;
                [UNC.EOT_VLDL_flux.max  , UNC.EOT_VLDL_flux.min ] =  calc_min_max( UNC.EOT_VLDL_flux.max ,UNC.EOT_VLDL_flux.min, EOT_VLDL_flux ) ;
                [UNC.EOT_BOX_flux.max  , UNC.EOT_BOX_flux.min ] =  calc_min_max( UNC.EOT_BOX_flux.max ,UNC.EOT_BOX_flux.min, EOT_BOX_flux ) ;
                [UNC.EOT_ratio_VLDL_flux.max  , UNC.EOT_ratio_VLDL_flux.min ] =  calc_min_max( UNC.EOT_ratio_VLDL_flux.max ,UNC.EOT_ratio_VLDL_flux.min, EOT_ratio_VLDL_flux ) ;
                [UNC.EOT_ratio_BOX_flux.max  , UNC.EOT_ratio_BOX_flux.min ] =  calc_min_max( UNC.EOT_ratio_BOX_flux.max ,UNC.EOT_ratio_BOX_flux.min, EOT_ratio_BOX_flux ) ;


                if strcmp(modelName, 'nafldv5')
                    list_var = { 'ff2', 'yDNL' , 'yBOX' , 'yVLDL' } ;

                else
                    list_var = { 'ff2', 'vDNL' , 'BHB' , 'VLDL' } ;

                end
                for ii = 1:size(list_var,2)

                    var = list_var{ii} ;

                    if strcmp('ff2', var)
                        vvar = s_d.variablevalues( : , ismember( SBvariables( objModel), var  ));


                    elseif   strcmp('vDNL', var)

                        baseline_vvar =   s_d.variablevalues( 1 , ismember( SBvariables( objModel), var  ));

                        vvar = ( s_d.variablevalues( : , ismember( SBvariables( objModel), var  ))./baseline_vvar )*100; % change in %

                    elseif strcmp('BHB', var) ||  strcmp('VLDL', var)

                        vvar = s_d.statevalues( :,  ismember( SBstates( objModel), var  ));

                    else
                        vvar = s_d.variablevalues( : , ismember( SBvariables( objModel), var  ));

                    end



                    if c == 1
                        UNC.(var).max  = vvar; UNC.(var).min  = vvar;
                        b_c.cost = cost;
                        b_c.(var).vvar = vvar;

                        t_d = s_d.time; t_b = s_b.time;
                    end

                    [UNC.(var).max  , UNC.(var).min ] =  calc_min_max( UNC.(var).max ,UNC.(var).min, vvar ) ;

                    if cost < b_c.cost

                        b_c.cost = cost;
                        b_c.(var).vvar = vvar;


                        b_c.Baseline_TOTAL_FAT_FLUX = Baseline_TOTAL_FAT_FLUX;
                        b_c.Baseline_DNL_flux = Baseline_DNL_flux;
                        b_c.Baseline_AT_FA_flux = Baseline_AT_FA_flux;
                        b_c.Baseline_Diet_FA_flux = Baseline_Diet_FA_flux;

                        b_c.Baseline_ratio_DNL_flux = Baseline_ratio_DNL_flux;
                        b_c.Baseline_ratio_AT_FA_flux = Baseline_ratio_AT_FA_flux;
                        b_c.Baseline_ratio_Diet_FA_flux = Baseline_ratio_Diet_FA_flux;

                        b_c.EOT_TOTAL_FAT_FLUX = EOT_TOTAL_FAT_FLUX;
                        b_c.EOT_DNL_flux = EOT_DNL_flux;
                        b_c.EOT_AT_FA_flux = EOT_AT_FA_flux;
                        b_c.EOT_Diet_FA_flux = EOT_Diet_FA_flux;

                        b_c.EOT_ratio_DNL_flux = EOT_ratio_DNL_flux;
                        b_c.EOT_ratio_AT_FA_flux = EOT_ratio_AT_FA_flux;
                        b_c.EOT_ratio_Diet_FA_flux = EOT_ratio_Diet_FA_flux;

                        b_c.Baseline_TOTAL_FAT_FLUX_EFFLUX = Baseline_TOTAL_FAT_FLUX_EFFLUX;
                        b_c.Baseline_VLDL_flux = Baseline_VLDL_flux;
                        b_c.Baseline_BOX_flux = Baseline_BOX_flux;

                        b_c.Baseline_ratio_VLDL_flux = Baseline_ratio_VLDL_flux;
                        b_c.Baseline_ratio_BOX_flux = Baseline_ratio_BOX_flux;

                        b_c.EOT_TOTAL_FAT_FLUX_EFFLUX = EOT_TOTAL_FAT_FLUX_EFFLUX;
                        b_c.EOT_VLDL_flux = EOT_VLDL_flux;
                        b_c.EOT_BOX_flux = EOT_BOX_flux;

                        b_c.EOT_ratio_VLDL_flux = EOT_ratio_VLDL_flux;
                        b_c.EOT_ratio_BOX_flux = EOT_ratio_BOX_flux;


                    end

                end

                clear s_b; clear s_d;
            end

            clear theta;

        end



    end
end


line_size_sim = 2 ;
line_size_data = 1.5 ;
marker_size    = 8;

col_fill = [0.4 0.8 0.8]; 

col_line = [0.2 0.4 1 ] ;

f1 = figure();

f1.Position = [0 0 2000 500];

list_var = { 'ff2', 'yDNL' , 'yBOX' , 'yVLDL' } ;

tmp = D.Mardinoglu.co1  ;

t_f = [ t_d fliplr(t_d)];  

tiledlayout(1,4 ,'TileSpacing','loose');

for jj = 1:size(list_var, 2)

    nexttile(jj)
  
    f = fill(t_f, [ UNC.(list_var{jj}).max' fliplr( UNC.(list_var{jj}).min' ) ], col_fill,'Edgecolor', 'none');

    set(f,'facealpha',.3)
    hold on

    plot ( t_d,  b_c.(list_var{jj}).vvar , "color", col_line , 'LineWidth', line_size_sim );

    if jj == 1
   title( {'Low carbohydrate high fat (LCHF)' ; 'Mardinoglu {\itet al.} 2018'; 'Isocaloric \Delta0 kcal' ; '72/4/24% (F/C/P)' } );    % use for title positioning
   ax = gca;
   ax.TitleHorizontalAlignment = 'left';


        errorbar( tmp.LF.Time , tmp.LF.Mean   , tmp.LF.SEM ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )
      
        ylabel('^1H-MRS PDFF  (%)' ,'fontweight','bold' ) ;
        ylim([  0   30 ]); yticks([ 0 10 20 30]);

    elseif jj == 2
        errorbar( tmp.DNL.Time , tmp.DNL.Mean  , tmp.DNL.SEM,'o' ,'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0])
        ylabel('DNL in VLDL-TAG (\mumol/L)' ,'fontweight','bold' );
           ylim([  0   450 ]); yticks([0 150 300 450]);

    elseif jj == 3
        errorbar( tmp.BHB.Time , tmp.BHB.Mean   , tmp.BHB.SEM ,'o' ,'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )
        ylabel(' \beta-hydroxybutyrate (mg/dL)' ,'fontweight','bold' );
         ylim([  0   4.5 ]); yticks([0 1.5 3 4.5]);

    elseif jj == 4
       errorbar( tmp.VLDL.Time , tmp.VLDL.Mean   , tmp.VLDL.SEM ,'o' ,'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0])
        ylabel('VLDL-TAG (mmol/L) ' ,'fontweight','bold' )
        ylim([  0   3 ]); yticks([0 1 2 3]);

    end

    xlim([0  tmp.LF.Time(end)]) ; 
    xticks([ 0  (tmp.LF.Time(end)/2)   tmp.LF.Time(end)]);
    xlabel('time (days)' ,'fontweight','bold' ) ;

    set(gca ,'fontsize' , 16)

    box 'off'

if jj == 1
legend('Model uncertainty', 'Simulation \theta_b_e_s_t', 'Mardinoglu {\itet al.} 2018')

end


    set(gcf,'color', 'w')
end

%%

f2 = figure();

f2.Position = [0 0 500 500];

DNL.Mean = 26.1; 
DNL.SEM = 6.7;

NEFA.Mean = 59.0;
NEFA.SEM = 9.9;

DietTAG.Mean = 14.9;
DietTAG.SEM = 7.0;

high = [UNC.Baseline_ratio_DNL_flux.max  ]*100  ;
low  = [UNC.Baseline_ratio_DNL_flux.min  ]*100  ;

rectangle('Position',[ 1.15 low(1)   0.2  abs( high(1) - low(1) )  ], 'FaceColor',col_fill,'EdgeColor','none'); 
hold on
plot([1.15 1.35] , [b_c.Baseline_ratio_DNL_flux b_c.Baseline_ratio_DNL_flux]*100 , 'color', col_line, 'LineWidth',1.5)

errorbar( 0.75 , DNL.Mean , DNL.SEM   ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )


high = [UNC.Baseline_ratio_Diet_FA_flux.max ]*100  ;
low  = [UNC.Baseline_ratio_Diet_FA_flux.min ]*100  ;

rectangle('Position',[ 3.15 low(1)   0.2  abs( high(1) - low(1) )  ], 'FaceColor',col_fill,'EdgeColor','none'); 
hold on
plot([3.15 3.35] , [b_c.Baseline_ratio_Diet_FA_flux b_c.Baseline_ratio_Diet_FA_flux]*100 , 'color', col_line, 'LineWidth',1.5)

errorbar( 2.75 , DietTAG.Mean , DietTAG.SEM   ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )


high = [UNC.Baseline_ratio_AT_FA_flux.max ]*100  ;
low  = [UNC.Baseline_ratio_AT_FA_flux.min ]*100  ;

rectangle('Position',[ 5.15 low(1)   0.2  abs( high(1) - low(1) )  ], 'FaceColor',col_fill,'EdgeColor','none'); 
hold on
plot([5.15 5.35] , [b_c.Baseline_ratio_AT_FA_flux b_c.Baseline_ratio_AT_FA_flux]*100 , 'color', col_line, 'LineWidth',1.5)

errorbar( 4.75 , NEFA.Mean , NEFA.SEM   ,'o' , 'color', [ 0 0 0], 'LineWidth', line_size_data ,'MarkerSize', marker_size , 'MarkerFaceColor', [ 1 1 1], 'MarkerEdgeColor', [ 0 0 0] )

ylim([0 100]);

xticklabels({'{\itv_D_N_L}','{\itv_D_i_e_t_a_r_y_T_A_G}' , '{\itv_N_E_F_A}'} ); xticks([1 3 5]) ;
ylabel({'Ratio influx (%)'}  ,'fontweight','bold' )

set(gca, 'fontsize', 20 );

set (gcf, 'color' ,'w')

box 'off'


legend('Model uncertainty', 'Simulation \theta_b_e_s_t', 'Donnelly {\itet al.} 2005','Location','northwest')



%%
function [max1, min1] = calc_min_max( in_max,in_min, sim )
max1= in_max; min1 = in_min;
max1( max1 < sim ) =  sim( max1 < sim);
min1( min1 > sim ) =  sim( min1 > sim);
end