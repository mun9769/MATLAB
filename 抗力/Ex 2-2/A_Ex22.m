%% Initialization

clc
clear
close all
format short eng

%% Simulation mode

Mode.PWM=2;         % PWM method
% 1: SCPWM, 2: 60deg DPWM, 3: 120deg(on) DPWM, 4: 120deg(off) DPWM

%% RL load parameters

R=1;
L=1e-3;

%% System parameters

Vdc = 250;

fsw=5e3;       % Switching frequency
Tsw=1/fsw;      % Switching period

fs=2*fsw;       % Samping frequency (double sampling)
Ts=1/fs;        % Samping period

%% Command setting

Stop_Time=0.1;

V=120;          % Amplitude of output voltage
W=2*pi*20;     % Angular speed of output voltage

%% Run Simulink

sim('Sim_Ex22.slx')
