% Script to calculate the degrees of freedom /number of data point for each
% data set. 

idxz = 1;

alpha = 0.95;

%% Mardinoglu et al. (2018)
utility.dgf.Marin.Baseline =   numel([ D.Mardinoglu.co1.LF.Mean(idxz)  D.Mardinoglu.co1.DNL.Mean(idxz)  D.Mardinoglu.co1.BHB.Mean(idxz)    D.Mardinoglu.co1.VLDL.Mean(idxz)  ]) ;
utility.dgf.Marin.Dynamic  =   numel([ D.Mardinoglu.co1.LF.Mean  D.Mardinoglu.co1.DNL.Mean  D.Mardinoglu.co1.BHB.Mean    D.Mardinoglu.co1.VLDL.Mean                              ]) ;


%% Luukkonen et al. (2020)
utility.dgf.Luukkonen2020.Baseline =  numel([ D.Luukkonen2020.LCHF.LF.Mean(idxz)      D.Luukkonen2020.LCHF.BHB.Mean(idxz)          ]) ;
utility.dgf.Luukkonen2020.Dynamic  =  numel([ D.Luukkonen2020.LCHF.LF.Mean             D.Luukkonen2020.LCHF.BHB.Mean                 ]) ;


%% Luukkonen et al. (2018)
utility.dgf.Luukkonen2018.Baseline =   numel([ D.Luukkonen2018.HCOF.LF.Mean(idxz) ]) ;
utility.dgf.Luukkonen2018.Dynamic  =   numel([ D.Luukkonen2018.HCOF.LF.Mean        ]) ;


%% Johnston et al. (2013)
utility.dgf.Johnston2013.HC_ISO_F.Baseline =    numel([ D.Johnston2013.HC_ISO_F.LF.Mean(idxz) ]) ;
utility.dgf.Johnston2013.HC_ISO_F.Dynamic =     numel([ D.Johnston2013.HC_ISO_F.LF.Mean        ]) ;

utility.dgf.Johnston2013.HC_OF_F.Baseline =    numel([ D.Johnston2013.HC_OF_F.LF.Mean(idxz) ]) ;
utility.dgf.Johnston2013.HC_OF_F.Dynamic  =    numel([ D.Johnston2013.HC_OF_F.LF.Mean        ]) ;


%% Holmer et al. (2021)
utility.dgf.Holmer2021.Baseline =   numel([ D.Holmer2021.LCHF.LF.Mean(idxz)       ]) ;
utility.dgf.Holmer2021.Dynamic  =   numel([ D.Holmer2021.LCHF.LF.Mean              ]) ;


%% Taskinen et al. (2017)
utility.dgf.Taskinen2017.Baseline =    numel([ D.Taskinen2017.HC_F.LF.Mean(idxz)       ]) ;
utility.dgf.Taskinen2017.Dynamic  =    numel([ D.Taskinen2017.HC_F.LF.Mean              ]) ;



%% Browning et al. (2011)
utility.dgf.Browning2011.Baseline =    numel([ D.Browning2011.LCHF.LF.Mean(idxz)       ]) ;
utility.dgf.Browning2011.Dynamic  =    numel([ D.Browning2011.LCHF.LF.Mean              ]) ;


%% Lawitz et al. (2018)

utility.dgf.Lawitz2018.Baseline =    numel([ D.Lawitz2018.LF.Mean(idxz)       ]) ;
utility.dgf.Lawitz2018.Dynamic  =    numel([ D.Lawitz2018.LF.Mean    D.Lawitz2018.DNL.Mean(2)      ]) ;
