function[ cost ]= cost_Taskinen_2017( D, s_b, s_d , utility , prediction_flag)

tmp = 'Taskinen2017';


if  prediction_flag == 0

idx = ismember(s_d.time , D.(tmp).HC_F.LF.Time );

idx_data = [ 1   2 ] ;

elseif  prediction_flag == 1

idx = 1;
idx_data = 1;   

elseif  prediction_flag == 2

idx = 2;
idx_data = 2;   

end


if prediction_flag == 2

c1 = sum( ( ( s_d.variablevalues( idx,end)' - D.(tmp).HC_F.LF.Mean(idx_data) ).^2)./( D.(tmp).HC_F.LF.SEM(idx_data).^2)) ;


 y2 = s_d.variablevalues( idx ,ismember(SBvariables(utility.objModel), 'yDNL' ))./s_d.variablevalues(1,ismember(SBvariables(utility.objModel), 'yDNL' ));  % fold


c2 = sum( ( (  y2  -D.(tmp).HC_F.DNL.Mean(idx_data)' ).^2)./D.(tmp).HC_F.DNL.SEM(idx_data)' ) ;


BHB_data_fold_mean =  (D.(tmp).HC_F.BHB.Mean(idx_data)')/D.(tmp).HC_F.BHB.Mean(1) ;
BHB_data_fold_SEM =  (D.(tmp).HC_F.BHB.SEM(idx_data)')/D.(tmp).HC_F.BHB.Mean(1)   ;

 y3 = s_d.variablevalues( idx ,ismember(SBvariables(utility.objModel), 'yBHB' ))./ ( BHB_data_fold_SEM);  % fold

c3 = sum( ( ( y3-  BHB_data_fold_mean  ).^2)./(D.(tmp).HC_F.BHB.SEM(idx_data).^2 )  ) ;


c1 = c1 + c2 +c3;

else

c1 = sum( ( ( s_d.variablevalues( idx,end)' - D.(tmp).HC_F.LF.Mean(idx_data) ).^2)./( D.(tmp).HC_F.LF.SEM(idx_data).^2)) ;

end




%% Adhoc - States
adhoc=0;

if sum( abs( s_d.statevalues(s_d.statevalues < 0) ))  > 0 || sum( abs( s_d.variablevalues(s_d.statevalues < 0) ))  > 0
    adhoc =  adhoc + chi2inv(0.95,20)*10;
elseif sum( abs( s_b.statevalues(s_d.statevalues < 0) ))  > 0 || sum( abs( s_b.variablevalues(s_d.statevalues < 0) ))  > 0
    adhoc =  adhoc + chi2inv(0.95,20)*10;
end


%%%% 1 FA INFLUX RATIOS from literatrue 

%%%Of the TAG accounted for in liver, 59.0% ± 9.9% of TAG arose from NEFAs; 26.1% ± 6.7%, from DNL; and 14.9% ± 7.0%, from the diet.

DNL_flux     = s_b.variablevalues(end, ismember(SBvariables(utility.objModel),'vDNL')) ;
AT_FA_flux   = s_b.variablevalues(end, ismember(SBvariables(utility.objModel),'vAdipose_NEFA')) ;
Diet_FA_flux = s_b.variablevalues(end, ismember(SBvariables(utility.objModel),'vDietary_TG')) ;

TOTAL_FAT_FLUX = s_b.variablevalues(end, ismember(SBvariables(utility.objModel),'vTOTAL_FAT_FLUX')) ;


% These patinets barley have NAFLD. mean 4.7 %
cohort_extended_limit = 19; %Adding extra freedom for DNL and fat flux limits

%%% DNL
ratio_DNL = (DNL_flux/TOTAL_FAT_FLUX )*100; % ratio DNL total FA influx to TG
adhoc_DNL = 0;
if ratio_DNL > 32.8 
adhoc_DNL =  adhoc_DNL + max(0, ratio_DNL - 32.8  ) +  36.4150;  
elseif ratio_DNL < ( 19.4 - cohort_extended_limit )
adhoc_DNL =  adhoc_DNL + max(0, 19.4 - ratio_DNL  ) +  36.4150;  
end

%%% Diet flux
ratio_Diet_FA = (Diet_FA_flux/TOTAL_FAT_FLUX )*100; % ratio DNL total FA influx to TG
adhoc_Diet_FA = 0;
if ratio_Diet_FA >  ( 21.9 + cohort_extended_limit)
adhoc_Diet_FA =  adhoc_Diet_FA + max(0, ratio_DNL -  21.9  ) +  36.4150;  
elseif ratio_Diet_FA < 7.9 
adhoc_Diet_FA =  adhoc_Diet_FA + max(0, 7.9 - ratio_DNL  ) +  36.4150;  
end

adhoc = adhoc + adhoc_DNL + adhoc_Diet_FA;


%% Total cost
cost = c1  +adhoc ;




end




