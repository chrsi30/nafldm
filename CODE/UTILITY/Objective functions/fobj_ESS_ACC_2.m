function[ cost ]= fobj_ESS_ACC_2( theta ,func_mex_model, D, utility , p , flag, prediction_flag, unc_flag)

global validp


if sum(p < 0 ) > 1
p = exp(p)' ;
end


%ACC_inhib_effect = theta(2);

theta = [ p , theta] ;

p = parameter_sorting(theta, utility , flag) ;


%% BYSEN 
[~, s_d ] = f_sim_Beysen_2020( p.study1 ,func_mex_model, D, utility  );

%%% Cost calculation
idx     = ismember(s_d.time , D.Beysen2020.FT_4101_3mg.LF.Time(1)  );
c1 = sum( ( (s_d.variablevalues(idx,end) - D.Beysen2020.FT_4101_3mg.LF.Mean(1)' ).^2)./(D.Beysen2020.FT_4101_3mg.LF.SEM(1)'.^2) ) ;

%%
[~, s_d ] = f_sim_Lawitz_2018( p.study2  ,func_mex_model, D, utility  );
idx     = ismember(s_d.time , D.Lawitz2018.LF.Time(1)  );
c2 = sum( ( (s_d.variablevalues(idx,end) - D.Lawitz2018.LF.Mean(1)' ).^2)./(D.Lawitz2018.LF.SEM(1)'.^2) ) ;


cost = c1 + c2;

%%

limit = chi2inv(0.95, 2 ) ; 




if unc_flag == 1

if cost < limit

validp = [ validp; table( theta, cost, 'VariableNames', {'theta','cost'})];

if size(validp,1) > 10000

folder = ['./Results/Sampling_simple/Calibration/' utility.modelName '/Sampling_based/BYSEN2020/' utility.bof_string '/'] ;

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









