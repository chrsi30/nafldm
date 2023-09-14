%%
msg = "What studies to callibrate on:";
menu_opt = [ "1. All" ...
             "2. Bysen and Lawitz" ];


choice = menu(msg,menu_opt);

study_type_flag = choice;

msg = "Calibration CI";

menu_opt = [ "1. 20%" ...
             "2. 30%" ...
             "3. 40%" ...
             "4. 45%" ...
             "5. 80%" ...
             "6. 99%" ];

choice = menu(msg,menu_opt);

if     choice == 1; bof = 0.2;  bof_string = 'CI20%' ;
elseif choice == 2; bof = 0.3;  bof_string = 'CI30%' ;
elseif choice == 3; bof = 0.4;  bof_string = 'CI40%' ;
elseif choice == 4; bof = 0.45; bof_string = 'CI45%' ;
elseif choice == 5; bof = 0.8;  bof_string = 'CI80%' ;
elseif choice == 6; bof = 0.99; bof_string = 'CI99%' ;
end


%%
msg = "What to estimate to use??";
menu_opt = ["1. Full - calibrate all " ...
            "2. 7P" ...  
            "3. 1P - DNL" ...
            "4. 2P - DNL + BOX"...
            "5. 4P - DNL + BOX"...
            "5. 5P - DNL + BOX" ];

choice = menu(msg,menu_opt);

if choice == 1 
flag = 5; 
elseif choice == 2
flag = 6; 
bof_string = [ '7P_' bof_string ]  ; 
elseif choice == 3
flag = 7; 
bof_string = [ '1P_DNL' bof_string ]  ; 
elseif choice == 4
flag = 8; 
bof_string = [ '2P_DNL_BOX_' bof_string ]  ; 
elseif choice == 5
flag = 9; 
bof_string = [ '4_DNL_BOX_' bof_string ]  ; 
elseif choice == 6
flag = 10; 
bof_string = [ '5P_DNL_BOX_' bof_string ]  ; 
end

%%% SETUP OPTIONS FOR ESTIMATION

if study_type_flag == 1

study_type_string = 'Validation' ; num_s2c = 6;

[problem, opts ] = options_ess_b2_calibration(utility.pNames, flag  , num_s2c, bof , study_type_flag) ;             

prediction_flag = 1; % Calibrating only basline (everytime)

anonymous = @(theta) fobj_ess_calib( theta ,func_mex_model, D, utility  , p ,flag , prediction_flag ,  1 );

limit = chi2inv(0.95, (sum([utility.dgf.Luukkonen2020.Baseline...
                            utility.dgf.Luukkonen2018.Baseline...
                            utility.dgf.Johnston2013.HC_ISO_F.Baseline...
                            utility.dgf.Johnston2013.HC_OF_F.Baseline...
                            utility.dgf.Holmer2021.Baseline ...
                            utility.dgf.Taskinen2017.Baseline ...
                            utility.dgf.Browning2011.Baseline ]   )) ) ;

elseif study_type_flag == 2

study_type_string = 'BYSEN_LAWITZ' ; num_s2c = 2;

[problem, opts ] = options_ess_b2_calibration(pNames, flag  , num_s2c, bof , study_type_flag) ;             

prediction_flag = 1; 

anonymous = @(theta) fobj_ess_ACC_2( theta ,func_mex_model, D, utility  , p , flag  , prediction_flag,  1 );

limit = chi2inv(0.95, 2   ) ;

end


