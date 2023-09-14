function[ cost ]= fobj_MS( theta ,func_mex_model, D, utility  )
if sum(theta < 0 ) > 1
theta = exp(theta)' ;
end

try

[ s_b, s_d ] = f_sim_Marin_2018_co1( theta ,func_mex_model, D, utility ) ; 

c1 = cost_Marin_2018_co1(D,s_b, s_d ,utility );

cost = c1 ;
catch
    cost = 1e99;
end
end




