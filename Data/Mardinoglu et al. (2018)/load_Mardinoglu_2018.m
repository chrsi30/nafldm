% Digitized data
% https://www.sciencedirect.com/science/article/pii/S1550413118300548?via%3Dihub 

%% Cohort 2
D.Mardinoglu.co2.DNL.LF = [0 1 3 7 10 14];

% We also served the identical isocaloric low-carbohydrate diet with
% increased protein content to a second cohort of seven subjects
% for 7 days. In this second cohort of similar age (p = 0.379) and
% BMI (p = 0.230), we confirmed that the diet reduced DNL, fasting
% plasma triglycerides, plasma concentrations of alkaline phosphatase
% and insulin, and HOMA-IR values (Table S4). Analysis
% of liver biopsies taken from these subjects 7 days before the
% study start and after 7 days of dietary intervention showed that
% the diet significantly reduced the hepatic triglycerides by a
% mean of 43.9%(Table S4).

% Bodyweight
% 98.4±6.6	97.5±6.8
D.Mardinoglu.co2.BW.Time = [0  7];
D.Mardinoglu.co2.BW.Mean = [98.4     97.5  ];
D.Mardinoglu.co2.BW.SEM =  [6.6      6.8];

% DNL
% 67.4±17.4	2.7±0.9	

D.Mardinoglu.co2.DNL.Time = [0  7];
D.Mardinoglu.co2.DNL.Mean = [67.4     2.7 ];
D.Mardinoglu.co2.DNL.SEM =  [17.4     0.9 ];

% TG/PC ratio in the liver biopsy samples 
% 12.5±2.7	7.7±2.2	

D.Mardinoglu.co2.LF.Time = [0  7];
D.Mardinoglu.co2.LF.Mean = [12.5     7.7 ];
D.Mardinoglu.co2.LF.SEM =  [2.7	     2.2 ];


%% Cohort 1
D.Mardinoglu.co1.Time = [0 1 3 7 14];

% Weight
%107.2±6.0	106.5±5.9	106.0±5.9	105.6±5.8	105.2±5.8
D.Mardinoglu.co1.BW.Time = [0 1 3 7 14];
D.Mardinoglu.co1.BW.Mean = [107.2   106.5   106.0   105.6   105.2];
D.Mardinoglu.co1.BW.SEM =  [6.0     5.9     5.9     5.8     5.8  ];

% Liver fat
D.Mardinoglu.co1.LF.Time = [0 1 3 7 14];
%D.Mardinoglu.co1.DNL.LF.Mean = [16.03 15.38 13.75  12 10.80 9.76]; From
%publication. One extra data point ( 10 min)

D.Mardinoglu.co1.LF.Mean = [16.0  15.3  13.8  12   9.7]; % From supplement
D.Mardinoglu.co1.LF.SEM  = [2.3   2.3   2.4   2.4  1.9];

% To test whether the marked reductions in liver fat were linked
% to the diet intervention, we performed a follow-up MRS in seven
% of the ten participants 1–3 months after completing the intervention
% study and returning to their normal diet. We observed that
% their liver fat content returned to a level similar to that measured
% before the diet intervention (11.3% ± 1.6% at follow-up versus
% 13.8% ± 2.5% at baseline, p = 0.08).

% DNL
D.Mardinoglu.co1.DNL.Time=[ 0 3 14];
D.Mardinoglu.co1.DNL.Mean = [217.0801951 63.82360597 50.31528922]; % NOT REAL VALUES -  APPROXIMATE FROM PUBLISHED GRAPHS showing MEDIAN VALUE.
D.Mardinoglu.co1.DNL.SEM = [109.8936161 51.08105158 45.31768223];

%%% ?-hydroxybutyrate* (mg/dL)	0.6±0.1	1.97±0.37	2.24±0.44	2.13±0.3	2.61±0.6 
% (BETA oxidation )
D.Mardinoglu.co1.BHB.Time=[ 0 1 3 7 14];
% digitized from publication 
% D.Mardinoglu.co1.BHB.Mean = [0.757662835 2.219348659 3.795019157]./0.757662835;
% D.Mardinoglu.co1.BHB.SEM = [0.489463602 1.159961686 1 ]./0.757662835; 

% D.Mardinoglu.co1.BHB.fold.Mean = [0.6  1.97  2.24  2.13  2.61 ]./0.6;
% D.Mardinoglu.co1.BHB.fold.SEM  = [0.1  0.37  0.44  0.3   0.6 ]./0.6; 

D.Mardinoglu.co1.BHB.Mean = [0.6  1.97  2.24  2.13  2.61 ];
D.Mardinoglu.co1.BHB.SEM  = [0.1  0.37  0.44  0.3   0.6 ]; 

D.Mardinoglu.co1.BHB.fold.Mean = [0.6  1.97  2.24  2.13  2.61 ]./0.6;
D.Mardinoglu.co1.BHB.fold.SEM  = [0.1  0.37  0.44  0.3   0.6 ]./0.6 ; 

% VLDL-TAG
%2.3±0.4	3.1±1.2	1.4±0.4	0.98±0.36	0.95±0.25

D.Mardinoglu.co1.VLDL.Time=[ 0  3 7 14]; % 1 EXLUDED day 1 data
% digitized from publication 
% D.Mardinoglu.co1.VLDL.Mean = [2.972651077 1.07009625 0.74391977]./2.972651077 ;
% D.Mardinoglu.co1.VLDL.SEM = [1.996826653 0.769072381 0.497884435]./2.972651077 ;

D.Mardinoglu.co1.VLDL.Mean = [ 2.3   1.4  0.98  0.95 ]; %./2.3; % 3.1  
D.Mardinoglu.co1.VLDL.SEM = [ 0.4    0.4  0.36  0.25 ]; %./2.3; %  1.2 

D.Mardinoglu.co1.VLDL.fold.Mean = [ 2.3   1.4  0.98  0.95 ]./2.3; % 3.1  
D.Mardinoglu.co1.VLDL.fold.SEM = [ 0.4    0.4  0.36  0.25 ]/2.3; %  1.2 

% D.Mardinoglu.co1.VLDL.Mean = [ 2.3  3.1  1.4  0.98  0.95 ];
% D.Mardinoglu.co1.VLDL.SEM = [ 0.4   1.2  0.4  0.36  0.25 ];

% HOMA - IR
D.Mardinoglu.co1.HOMAIR.Mean =[	6.0	5.7	4.4	4.8	5.0 ];
D.Mardinoglu.co1.HOMAIR.SEM = [1.4  1.2 0.8 1.2 1.1] ;
% NEFA

D.Mardinoglu.co1.NEFA.Mean = [ 524.5	504.5 466.4	431.0 480.7 ];
D.Mardinoglu.co1.NEFA.SEM = [52.1  42.4 66.3 48.1 63.2 ];

% TAG
D.Mardinoglu.co1.NEFA.Mean = [2.8 3.7 1.9 1.4 1.4  ] ;
D.Mardinoglu.co1.NEFA.SEM = [0.4 1.3 0.4 0.4 0.3 ];



