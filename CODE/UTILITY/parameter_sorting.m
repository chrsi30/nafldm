function [p]= parameter_sorting(theta, utility, flag)
% function to assign calibration parameter(s) for each study. 
% All results in the article used the simplest calibration.  flag = 7.
% where only one paramter governing the DNL is re-calibrated

num_opt = find(strcmp('cf', utility.pNames)) - 1;

p.main = theta(1:num_opt);

%% Callibration of only specific parameters -- set manually
if flag == 6 

num_of_w = 7 ;

wv = theta(num_opt+1 : end);

num_swp = length(wv)/num_of_w;


idx.kDTG         = ismember( utility.pNames, 'kDTG' ) ;
idx.kNEFAuptakeH = ismember( utility.pNames, 'kNEFAuptakeH' ) ;
idx.kDNL         = ismember(utility.pNames , 'kDNL' );
idx.kBOX         = ismember(utility.pNames,  'kBOX') ;
idx.kbasalBHB    = ismember(utility.pNames,  'kbasalBHB') ;
idx.kdegBHB      = ismember(utility.pNames,  'kdegBHB') ;
idx.kVLDL        = ismember(utility.pNames,  'kVLDL') ;


for j = 1:num_swp
vx =  1 + 1*(num_of_w*(j-1)) ;

w = wv( vx: ( vx + num_of_w) - 1 );

p.(['study' int2str(j)]) = p.main(1:(end)) ;

p.(['study' int2str(j)])(idx.kDTG)          = p.(['study' int2str(j)])(idx.kDTG)*w(1) ;
p.(['study' int2str(j)])(idx.kNEFAuptakeH ) = p.(['study' int2str(j)])(idx.kNEFAuptakeH )*w(2) ;
p.(['study' int2str(j)])(idx.kDNL)          = p.(['study' int2str(j)])(idx.kDNL)*w(3) ;
p.(['study' int2str(j)])(idx.kBOX )         = p.(['study' int2str(j)])(idx.kBOX )*w(4) ;
p.(['study' int2str(j)])(idx.kbasalBHB )    = p.(['study' int2str(j)])(idx.kbasalBHB )*w(5) ;
p.(['study' int2str(j)])(idx.kdegBHB)       = p.(['study' int2str(j)])(idx.kdegBHB)*w(6) ;
p.(['study' int2str(j)])(idx.kVLDL )        = p.(['study' int2str(j)])(idx.kVLDL )*w(7) ;

clear w ;

end

%% Callibration of only DNL parameter -- set manually
elseif flag == 7

num_of_w = 1 ;

wv = theta(num_opt+1 : end);

num_swp = length(wv)/num_of_w;

idx.kTCA         = ismember(utility.pNames , 'kTCA' );

for j = 1:num_swp
vx =  1 + 1*(num_of_w*(j-1)) ;

w = wv( vx: ( vx + num_of_w) - 1 );

p.(['study' int2str(j)]) = p.main(1:(end)) ;

p.(['study' int2str(j)])(idx.kTCA)          = p.(['study' int2str(j)])(idx.kTCA)*w(1) ;

clear w ;

end
%%
elseif flag == 8

num_of_w = 2 ;

wv = theta(num_opt+1 : end);

num_swp = length(wv)/num_of_w;

idx.kTCA         = ismember(utility.pNames , 'kTCA' );
idx.kBOX         = ismember(utility.pNames,  'kBOX') ;

for j = 1:num_swp
vx =  1 + 1*(num_of_w*(j-1)) ;

w = wv( vx: ( vx + num_of_w) - 1 );

p.(['study' int2str(j)]) = p.main(1:(end)) ;

p.(['study' int2str(j)])(idx.kTCA)          = p.(['study' int2str(j)])(idx.kTCA)*w(1) ;
p.(['study' int2str(j)])(idx.kBOX )         = p.(['study' int2str(j)])(idx.kBOX )*w(2) ;
end

clear w ;

elseif flag == 9

num_of_w = 4 ;

wv = theta(num_opt+1 : end);

num_swp = length(wv)/num_of_w;

idx.kDNL         = ismember(utility.pNames , 'kDNL' );
idx.kBOX         = ismember(utility.pNames,  'kBOX') ;
idx.kbasalBHB    = ismember(utility.pNames,  'kbasalBHB') ;
idx.kdegBHB      = ismember(utility.pNames,  'kdegBHB') ;

for j = 1:num_swp
vx =  1 + 1*(num_of_w*(j-1)) ;

w = wv( vx: ( vx + num_of_w) - 1 );

p.(['study' int2str(j)]) = p.main(1:(end)) ;

p.(['study' int2str(j)])(idx.kDNL)          = p.(['study' int2str(j)])(idx.kDNL)*w(1) ;
p.(['study' int2str(j)])(idx.kBOX )         = p.(['study' int2str(j)])(idx.kBOX )*w(2) ;
p.(['study' int2str(j)])(idx.kbasalBHB )    = p.(['study' int2str(j)])(idx.kbasalBHB )*w(3) ;
p.(['study' int2str(j)])(idx.kdegBHB)       = p.(['study' int2str(j)])(idx.kdegBHB)*w(4) ;
end

clear w ;




%%
elseif flag == 10



num_of_w = 5 ;

wv = theta(num_opt+1 : end);

num_swp = length(wv)/num_of_w;

idx.kDTG         = ismember( utility.pNames, 'kDTG' ) ;
idx.kDNL         = ismember(utility.pNames , 'kDNL' );
idx.kBOX         = ismember(utility.pNames,  'kBOX') ;
idx.kbasalBHB    = ismember(utility.pNames,  'kbasalBHB') ;
idx.kdegBHB      = ismember(utility.pNames,  'kdegBHB') ;

for j = 1:num_swp
vx =  1 + 1*(num_of_w*(j-1)) ;

w = wv( vx: ( vx + num_of_w) - 1 );

p.(['study' int2str(j)]) = p.main(1:(end)) ;

p.(['study' int2str(j)])(idx.kDTG)          = p.(['study' int2str(j)])(idx.kDTG)*w(1) ;
p.(['study' int2str(j)])(idx.kDNL)          = p.(['study' int2str(j)])(idx.kDNL)*w(2) ;
p.(['study' int2str(j)])(idx.kBOX )         = p.(['study' int2str(j)])(idx.kBOX )*w(3) ;
p.(['study' int2str(j)])(idx.kbasalBHB )    = p.(['study' int2str(j)])(idx.kbasalBHB )*w(4) ;
p.(['study' int2str(j)])(idx.kdegBHB)       = p.(['study' int2str(j)])(idx.kdegBHB)*w(5) ;
clear w ;

end

%% Callibration of all parameters
else %  flag < 7 && flag > 1

    num_of_w = num_opt;

    wv = theta(num_opt+1 : end);

    num_swp = length(wv)/num_of_w;

    for j = 1:num_swp

        vx = 1 + 1*(num_of_w*(j-1)) ;

        w = wv( vx: ( vx + num_of_w) - 1 );

        p.(['study' int2str(j)]) = p.main(1:(end)).*w ;

        clear w;
    end

end








end