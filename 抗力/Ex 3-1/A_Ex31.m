%% Initialization

clc
clear
close all
format short eng

%% Grid parameters in normal condition

Grid.V=220;                 % line-to-line RMS value, [V]
Grid.We=2*pi*60;            % Frequency, [rad/s]  
Grid.Thetae_Init=pi/180*0;  % Initial angle, [rad]

%% Grid parameters in fault condition
Grid.Time_Fault = 0;            % Time when the fault is occurred

                                % Positive sequence
Grid.Ratio_P=1;                 % Magnitude ratio

                                % Negative sequence
Grid.Ratio_N=0;                 % Magnitude ratio
Grid.Thetae_N_Init=pi/180*90;   % Initial angle

                                % 5th harmonic
Grid.Ratio_5th=0;             % Magnitude ratio
Grid.Thetae_5th_Init=pi/180*90; % Initial angle

                                % 7th harmonic
Grid.Ratio_7th=0;            % Magnitude ratio
Grid.Thetae_7th_Init=pi/180*0;  % Initial angle

%% Grid voltage setting
Grid.V_B=Grid.V*sqrt(2/3);              % Voltage base
                                        % Phase & peak value

Grid.V_P=Grid.V_B;         
Grid.V_N=Grid.Ratio_N*Grid.V_B;
Grid.V_5th=Grid.Ratio_5th*Grid.V_B;
Grid.V_7th=Grid.Ratio_7th*Grid.V_B;

%% Run simulink
Stop_Time=1/60;
sim('Sim_Ex31.slx')