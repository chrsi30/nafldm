function[ cost ]= cost_Marin_2018_co1( D, s_b, s_d , utility)


idx = ismember(s_d.time , D.Mardinoglu.co1.Time );

id_DNL  = ismember(s_d.time , [ 0 3 14]); % not the same time-points
id_VLDL = ismember(s_d.time , [ 0 3 7 14]); % not the same time-points


c1 = sum( ( (s_d.variablevalues(idx,end) - D.Mardinoglu.co1.LF.Mean' ).^2)./(D.Mardinoglu.co1.LF.SEM'.^2) ) ;

%if   strcmp( utility.modelName , 'nafldv5'  ) ||  strcmp( utility.modelName , 'nafldv6'  ) 

y2 = s_d.variablevalues(id_DNL,ismember(SBvariables(utility.objModel), 'yDNL' ));
c2 = sum( ( ( y2   - D.Mardinoglu.co1.DNL.Mean' ).^2) ./(D.Mardinoglu.co1.DNL.SEM'.^2) ) ;


y3 = s_d.variablevalues(idx,ismember(SBvariables(utility.objModel), 'yBOX' ));
c3 = sum( ( ( (y3 -D.Mardinoglu.co1.BHB.Mean') ).^2)./(D.Mardinoglu.co1.BHB.SEM'.^2) ) ;


y4 =  s_d.variablevalues(id_VLDL,ismember(SBvariables(utility.objModel), 'yVLDL' )) ;
c4 = sum( ( (y4 - D.Mardinoglu.co1.VLDL.Mean' ).^2)./(D.Mardinoglu.co1.VLDL.SEM'.^2) ) ;

%end






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
Diet_FA_flux = s_b.variablevalues(end, ismember(SBvariables(utility.objModel),'vDietary_TG')) ;

TOTAL_FAT_FLUX = s_b.variablevalues(end, ismember(SBvariables(utility.objModel),'vTOTAL_FAT_FLUX')) ;

%%% DNL
ratio_DNL = (DNL_flux/TOTAL_FAT_FLUX )*100; % ratio DNL total FA influx to TG
adhoc_DNL = 0;
if ratio_DNL > 32.8 
adhoc_DNL =  adhoc_DNL + max(0, ratio_DNL - 32.8  ) +  36.4150;  
elseif ratio_DNL < 19.4 
adhoc_DNL =  adhoc_DNL + max(0, 19.4 - ratio_DNL  ) +  36.4150;  
end

%%% Diet flux
ratio_Diet_FA = (Diet_FA_flux/TOTAL_FAT_FLUX )*100; % ratio DNL total FA influx to TG
adhoc_Diet_FA = 0;
if ratio_Diet_FA >  21.9 
adhoc_Diet_FA =  adhoc_Diet_FA + max(0, ratio_DNL -  21.9  ) +  36.4150;  
elseif ratio_Diet_FA < 7.9 
adhoc_Diet_FA =  adhoc_Diet_FA + max(0, 7.9 - ratio_DNL  ) +  36.4150;  
end


adhoc = adhoc + adhoc_DNL + adhoc_Diet_FA;



%% Total cost
cost = c1 +c2 +c3 + c4 +adhoc ;




end




