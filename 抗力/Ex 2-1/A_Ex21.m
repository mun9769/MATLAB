%% Initialization

clc
clear
close all
format short eng

%% RL load parameters

R=1;
L=1e-3;

%% System parameters

Vdc = 310;

fsw=2.5e3;       % Switching frequency
Tsw=1/fsw;      % Switching period

fs=2*fsw;       % Samping frequency (double sampling)
Ts=1/fs;        % Samping period

%% Command setting

Stop_Time=0.01;

V=120;          % Amplitude of output voltage
W=2*pi*200;          % Angular speed of output voltage


%% Run Simulink

sim('Sim_Ex21.slx')
