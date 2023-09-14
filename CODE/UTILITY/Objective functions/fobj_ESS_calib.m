function[ cost ]= fobj_ESS_calib( theta ,func_mex_model, D, utility , p ,flag , prediction_flag , unc_flag)

global validp

if sum(p < 0 ) > 1
p = exp(p)' ;
end

%% Parameters 

theta = [ p , theta ] ;

p = parameter_sorting(theta, utility , flag) ;

try
    % L20
    [ s_b, s_d ] = f_sim_Luukkonen_2020( p.study1 ,func_mex_model, D, utility ) ;

    c2 = cost_Luukkonen_2020(D,s_b, s_d ,utility , prediction_flag);

    %L18
    [ s_b, s_d ] = f_sim_Luukkonen_2018_HCOF( p.study2 ,func_mex_model, D, utility  ) ;

    c3 = cost_Luukkonen_2018_HCOF( D, s_b, s_d , utility  , prediction_flag ) ;

    % Overfeeding high fat
    [ s_b, s_d ] = f_sim_Luukkonen_2018_HFOF( p.study2 ,func_mex_model, D, utility  ) ;

    c4 = cost_Luukkonen_2018_HFOF( D, s_b, s_d , utility  , prediction_flag) ;

    %J13

    [ s_b, s_d ] = f_sim_Johnston_2013_HC_ISO_F( p.study3  ,func_mex_model, D, utility  ) ;

    c5 = cost_Johnston_2013_HC_ISO_F( D, s_b, s_d , utility  , prediction_flag ) ;


    [ s_b, s_d ] = f_sim_Johnston_2013_HC_OF_F( p.study3  ,func_mex_model, D, utility  ) ;


    c6 = cost_Johnston_2013_HC_OF_F( D, s_b, s_d , utility  , prediction_flag ) ;

    %H21

    [ s_b, s_d ] = f_sim_Holmer_2021( p.study4 ,func_mex_model, D, utility  ) ;


    c7 = cost_Holmer_2021( D, s_b, s_d , utility  , prediction_flag ) ;

    %T17

    [ s_b, s_d ] = f_sim_Taskinen_2017( p.study5  ,func_mex_model, D, utility  ) ;

    c8 = cost_Taskinen_2017( D, s_b, s_d , utility  , prediction_flag ) ;

    %B11

    [ s_b, s_d ] = f_sim_Browning_2011( p.study6  ,func_mex_model, D, utility  ) ;

    c9 = cost_Browning_2011( D, s_b, s_d , utility  , prediction_flag ) ;


    x =  c2 + c3 +c4 +c5 + c6 +c7 + c8 + c9;


    cost = x ;
catch
    cost = 1e99;
end

if unc_flag == 1
luukk2020_dgf  = 2 ; % BHB and LF basline
luukk2018_dgf  = 2 ; %LF + DNL?
johnston_dgf   = 2 ; %LF
holmer_dgf     = 1 ; %LF baseline
taskrinen_dgf  = 2 ; %LF BHB baseline
browning_dgf   = 1 ; %LF baseline
limit = chi2inv(0.95, (sum([ luukk2020_dgf luukk2018_dgf  johnston_dgf  holmer_dgf taskrinen_dgf browning_dgf]   )) ) ;

if cost < limit

validp = [ validp; table( theta, cost, 'VariableNames', {'theta','cost'})];

if size(validp,1) > 10000

folder = ['./Results/NEW/Sampling_simple/Calibration/' utility.modelName  '/' utility.bof_string '/' ] ;

if ~exist(folder,'dir')
    mkdir(folder)
end

save(  [ folder 'validp,'  datestr(now,'yymmdd-HHMMSS') '.mat' ]  ,'validp')


validp=[];


end   
end


end


end




