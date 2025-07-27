%% Initialization

clc
clear
close all
format short eng

%% Simulation mode
Mode.PWM=1;             % PWM method
% 1: SCPWM, 2: 60deg DPWM, 3: 120deg(on) DPWM, 4: 120deg(off) DPWM
Mode.CC_Type=1;         % Current controller type
% 1: State feedback, % A 2: Complex vector
Mode.NegSeqCC=1;        % Negative sequence current controller on
% 0: Off, 1: On

%% Grid parameters in normal condition
Grid.V=220;                             % Grid voltage, line-to-line RMS value, [V]
Grid.We=2*pi*60;                        % Frequency, [rad/s]  
Grid.Thetae_Init=pi/180*0;              % Initial angle, [rad]

%% Grid parameters in fault condition
Grid.Time_Fault = 0.1;                 % Time when the fault is occurred

                                        % Positive sequence
Grid.Ratio_P=1;                         % Magnitude ratio

                                        % Negative sequence
Grid.Ratio_N=0.333;                     % Magnitude ratio
Grid.Thetae_N_Init=pi/180*90;           % Initial angle

                                        % 5th harmonic
Grid.Ratio_5th=0;                       % Magnitude ratio
Grid.Thetae_5th_Init=pi/180*0;          % Initial angle

                                        % 7th harmonic
Grid.Ratio_7th=0;                       % Magnitude ratio
Grid.Thetae_7th_Init=pi/180*0;          % Initial angle

%% Grid voltage setting
Grid.V_B=Grid.V*sqrt(2/3);              % Voltage base
                                        % Phase & peak value

Grid.V_P=0*Grid.V_B;         
Grid.V_N=Grid.Ratio_N*Grid.V_B;
Grid.V_5th=Grid.Ratio_5th*Grid.V_B;
Grid.V_7th=Grid.Ratio_7th*Grid.V_B;

%% System parameters
Ls = 2e-3;
Rs = 0.1;

fsw=10e3;                   % Switching frequency
Tsw=1/fsw;                  % Switching period

fs=2*fsw;                   % Samping frequency (double sampling)
Ts=1/fs;                    % Samping period

%% Estimated parameters
Ls_Hat=1.0*Ls;
Rs_Hat=1.0*Rs;

%% Notch filter
NF.Wn=2*pi*120;
NF.Zeta=0.1;

%% Controller settings
                            % Phase locked loop
PLL.Wn=2*pi*5;              % natural frequency
PLL.Zeta=1;                 % damping ratio
PLL.We_FF=2*pi*60;          % nominal frequecy feed-forward
PLL.K_SOGI=1/sqrt(2);       % SOGI k-factor
E=Grid.V*sqrt(2/3);         % Grid phase voltage peak value

Vdc_Init=450;               % dc link voltage initial value

CC.Wc=300*2*pi;             % Current controller BW
CC.Ra=5*Rs_Hat;             % Active damping

run('GainCal');         	% Calculation of controller gains

%% Command setting
Time_CC_Ref=0.04;           % Current reference change time
CC.Ide_Ref=10;              
CC.Iqe_Ref=-20;

%% Run simulink
Stop_Time=0.2;
sim('Sim_Ex34.slx')