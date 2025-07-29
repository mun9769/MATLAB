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

V=310/sqrt(3);          % Amplitude of output voltage
W=2*pi*200;          % Angular speed of output voltage


%% Run Simulink

out=sim('Sim_Ex21.slx');

%%
[fig, ha, Sabc, Vdqss_Ref, ta, ps, text, arrow] = my_set_sixstep_fig(logsout);


prv = 1;
for ii=1:length(ta)
    
    arrow.UData = Vdqss_Ref(ii,1);
    arrow.VData = Vdqss_Ref(ii,2);

    cur = Sabc(ii,1);
    if cur == 0, cur = 7; end

    ps{prv}.MarkerFaceColor ='white';
    ps{cur}.MarkerFaceColor ='red';

    prv = cur;
    if mod(ii, 10) == 0
        t1.String = [num2str(ii/10) 's'];
    end
        pause(0.05);
end
