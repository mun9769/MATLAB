%% Initialization
clc
clear
close all
format short eng

%% Grid parameters in normal condition
Grid.V=220;                             % Grid voltage, line-to-line RMS value, [V]
Grid.We=2*pi*60;                        % Frequency, [rad/s]  
Grid.Thetae_Init=pi/180*80;             % Initial angle, [rad]

%% Grid parameters in fault condition
Grid.Time_Fault = 0.02;                 % Time when the fault is occurred
                                        
                                        % Positive sequence
Grid.Ratio_P=1;                         % Magnitude ratio

                                        % Negative sequence
Grid.Ratio_N=0;                         % Magnitude ratio
Grid.Thetae_N_Init=pi/180*90;           % Initial angle

                                        % 5th harmonic
Grid.Ratio_5th=0;                       % Magnitude ratio
Grid.Thetae_5th_Init=pi/180*90;         % Initial angle

                                        % 7th harmonic
Grid.Ratio_7th=0;                       % Magnitude ratio
Grid.Thetae_7th_Init=pi/180*90;         % Initial angle

%% Grid voltage setting
Grid.V_B=Grid.V*sqrt(2/3);              % Voltage base
                                        % Phase & peak value

Grid.V_P=Grid.V_B;         
Grid.V_N=Grid.Ratio_N*Grid.V_B;
Grid.V_5th=Grid.Ratio_5th*Grid.V_B;
Grid.V_7th=Grid.Ratio_7th*Grid.V_B;

%% System parameters
Fs=20e3;                               % Sampling frequency, [Hz]
Ts=1/Fs;                               % Sampling period, [s]

%% PLL gain design
                            % Phase locked loop
PLL.Wn=2*pi*5;              % natural frequency
PLL.Zeta=1;                 % damping ratio
PLL.We_FF=2*pi*60;          % nominal frequecy feed-forward
E=Grid.V_P;                 % Grid phase voltage peak value

PLL.Kp=2*PLL.Zeta*PLL.Wn/E;
PLL.Ki=PLL.Wn^2/E;

%% Run simulink
Stop_Time=0.3;
% sim('Sim_Ex32_Quiz.slx')
sim('Sim_Ex32.slx')