%% Initialization

clc
clear
close all
format short eng

%% Load Parameters

R=1;
L=1;

%% Controller Gain Design

Wcc=2*pi*1e3; % 1kHz BW
Kp=L*Wcc;
Ki=R*Wcc;

%% Command Setting

Step_Time=1e-3;
Stop_Time=5e-3;

I_Ref_Set=[0 10];


%% Run Simulink

sim('Sim_Ex12.slx')
