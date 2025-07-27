%% Initialization

clc
clear
close all
format short eng

%% Machine parameters

p=3;                            % # of pole pairs
Lamf=0.254;
Lds=3.6e-3;
Lqs=4.3e-3;
Rs=0.15;
Is_Rated=39.5*sqrt(2);          % Peak Value

Jm=0.001;
Bm=0;

%% Command setting

Thetarm_Init=0*pi*1/p;
Wrm_Init=0*2*pi/60;
Wrpm_Target=1750;                   % [r/min]
Stop_Time=0.5;

Wrm_Target=Wrpm_Target*2*pi/60;     % [rad/s]
Wr_Target=Wrm_Target*p;           % [rad/s]

Vdqsr=[0;Wr_Target*Lamf];

%% Run Simulink

sim('Sim_Ex14.slx')
