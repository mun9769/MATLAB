%% Initialization

clc
clear
close all
format short eng
global Vdc;
%% RL load parameters

R=1;
L=1e-3;

%% System parameters

Vdc = 310;

fsw=2500;       % Switching frequency
Tsw=1/fsw;      % Switching period

fs=2*fsw;       % Samping frequency (double sampling)
fs=5000;       % Samping frequency (double sampling)
Ts=1/fs;        % Samping period

%% Command setting

Stop_Time=0.01;

V=120;          % Amplitude of output voltage
W=2*pi*200;          % Angular speed of output voltage


%% Run Simulink

out=sim('Sim_Ex21.slx');

[fig, ha, Sabc, Vdqss_Ref, ta, ps] = my_set_sixstep_fig(logsout);

for ii=1:length(ta)
    
    quiver(0, 0, Vdqss_Ref(ii,1), Vdqss_Ref(ii,2))
    
    ps(round(Sabc(ii))+1).MarkerFaceColor ='white';
    pause(0.2);
end
