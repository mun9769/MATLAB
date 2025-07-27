%% Initialization

clc
clear
close all
format short eng

%% Machine parameters

p=3;                        % # of pole pairs
Lamf=0.254;
Lds=3.6e-3;
Lqs=4.3e-3;
Rs=0.15;
Is_Rated=39.5*sqrt(2);      % Peak Value

Jm=0.01;
Bm=.018;

%% Estimated parameters

Lamf_Hat=1.0*Lamf;
Rs_Hat=1.0*Rs;
Lds_Hat=1.0*Lds;
Lqs_Hat=0.5*Lqs;
Jm_Hat=1.0*Jm;
Bm_Hat=1.0*Bm;

%% Controller setting

Ra=10*Rs_Hat;            % Active damping
Wcc=500*2*pi;           % Current controller BW

Kp_Mat=Wcc*[Lds_Hat 0;0 Lqs_Hat];
Ki_Mat=Wcc*(Rs_Hat+Ra)*eye(2);

%% Command setting

Thetarm_Init=0*pi*1/p;

Wrm_Init=4000*2*pi/60;
Wrm_Fin=4000*2*pi/60;

Idqsr_Ref_Set=[0 -5;0 10];
Step_Time=0.005;

Stop_Time=0.1;


%% Run Simulink

sim('Sim_Ex16.slx')
