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



test =       (logsout.get("test").Values.Data );
tt = logsout.get("test").Values.Time;

Sabc =       (logsout.get("Sabc").Values.Data );
ta = logsout.get("Sabc").Values.Time;

test_interpolate = interp1(tt,test, ta, 'previous');

test_interpolate( isnan(test_interpolate) ) = 0;

% plot(ta, test_interpolate);


li = zeros(size(Sabc));
for ii=1:length(Sabc)

    li(ii) = Sabc(ii,1)*4 + Sabc(ii,2)*2 + Sabc(ii,1);
end

plot(ta, li);


