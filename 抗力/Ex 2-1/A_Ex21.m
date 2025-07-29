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

fsw=10000;       % Switching frequency
Tsw=1/fsw;      % Switching period

fs=2*fsw;       % Samping frequency (double sampling)
fs=10000;       % Samping frequency (double sampling)
Ts=1/fs;        % Samping period

%% Command setting

Stop_Time=0.01;

V=310/1.5;          % Amplitude of output voltage
W=2*pi*200;          % Angular speed of output voltage


%% Run Simulink

out=sim('Sim_Ex21.slx');

%%
[Sabc, Vdqss_Ref, ta, tt] = my_param(logsout);
[fig, ha, ps, text, arrow, pcur] = my_set_sixstep_fig(ta, Sabc);


prv = 7;
for ii=1:length(ta)
    
    arrow.UData = Vdqss_Ref(ii,1);
    arrow.VData = Vdqss_Ref(ii,2);

    cur = Sabc(ii,1);
    if cur == 0, cur = 7; end

    ps{prv}.MarkerFaceColor ='white';
    ps{cur}.MarkerFaceColor ='red';

    prv = cur;
    
    if mod(ii, 50) == 0
        text.String = [num2str(10*ii) 'us'];
    end
    pcur.XData = ta(ii); pcur.YData = Sabc(ii,1);
    pause(0.07);
end
