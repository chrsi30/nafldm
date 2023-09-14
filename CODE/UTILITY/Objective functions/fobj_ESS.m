function[ cost ]= fobj_ESS( theta ,func_mex_model, D, utility , unc_flag )

global validp

if sum(theta < 0 ) > 1
theta = exp(theta)' ;
end
%% Parameters 

%try

%% M18 - LCHF
% All datapoints is always included in the training.
[ s_b, s_d ] = f_sim_Marin_2018_co1( theta ,func_mex_model, D, utility ) ; 

c1 = cost_Marin_2018_co1(D,s_b, s_d ,utility );

cost = c1 ; %% Total cost

%% UNC

limit = chi2inv(0.95,  utility.dgf.Marin.Dynamic   ) ;

if unc_flag == 1

if cost < limit

validp = [ validp; table( theta, cost, 'VariableNames', {'theta','cost'})];

if size(validp,1) > 10000

folder = ['../../Results/NEW/Sampling_simple/Estimation_ESS/' utility.modelName  '/' utility.bounds_size_string '/'] ;

if ~exist(folder,'dir')
    mkdir(folder)
end

save(  [ folder 'validp,'  datestr(now,'yymmdd-HHMMSS') '.mat' ]  ,'validp')



validp=[];


end   
end
end

% catch
%     cost = 1e99;
% 
% end




end




