%% Initialization
clc
clear
close all
format short eng

%% Simulation mode
Mode.Ctrl=2;    
%: 1: Current Control Mode, 2: Voltage Control Mode
Mode.PWM=1;         % PWM method
% 1: SCPWM, 2: 60deg DPWM, 3: 120deg(on) DPWM, 4: 120deg(off) DPWM
Mode.CC_Type=1;     % Current controller type
% 1: State feedback, % A 2: Complex vector
Mode.NegSeqCC=1;    % Negative sequecne current controller
% 0: Off, 1: On
Mode.HCC=1;      % Harmonic current controller (HCC)
% 0: Off, 1: On
Mode.Pload_FF=0;    % Lower power feed-forward
% 0: Off, 1: On

%% Grid parameters in normal condition
Grid.V=220;                             % Grid voltage, line-to-line RMS value, [V]
Grid.We=2*pi*60;                        % Frequency, [rad/s]  
Grid.Thetae_Init=pi/180*0;              % Initial angle, [rad]

%% Grid parameters in fault condition
Grid.Time_Fault = 0.1;                  % Time when the fault is occurred
                                        
                                        % Positive sequence
Grid.Ratio_P=1;                         % Magnitude ratio

                                        % Negative sequence
Grid.Ratio_N=0;                         % Magnitude ratio
Grid.Thetae_N_Init=pi/180*90;           % Initial angle

                                        % 5th harmonic
Grid.Ratio_5th=0;                       % Magnitude ratio
Grid.Thetae_5th_Init=pi/180*0;          % Initial angle

                                        % 7th harmonic
Grid.Ratio_7th=0;                       % Magnitude ratio
Grid.Thetae_7th_Init=pi/180*0;          % Initial angle

%% Grid Voltage setting
Grid.V_B=Grid.V*sqrt(2/3);              % Voltage base
                                        % Phase & peak value

Grid.V_P=Grid.Ratio_P*Grid.V_B;         
Grid.V_N=Grid.Ratio_N*Grid.V_B;
Grid.V_5th=Grid.Ratio_5th*Grid.V_B;
Grid.V_7th=Grid.Ratio_7th*Grid.V_B;

%% System parameters
Cdc=3.3e-3;     
Is_Rated=50;

Ls = 2e-3;
Rs = 0.1;

fsw=10e3;       % Switching frequency
Tsw=1/fsw;      % Switching period

fs=2*fsw;       % Samping frequency (double sampling)
Ts=1/fs;        % Samping period

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
E=Grid.V_P;                 % Grid phase voltage peak value
                            
                            % dc link voltage
VC.Wn=2*pi*10;              % controller natural frequency
VC.Zeta=sqrt(2);            % damping ratio
Vdc_Init=450;               % initial value
Vdc_OP=500;               % operating point

CC.Wc=300*2*pi;             % Current controller BW
CC.Ra=5*Rs_Hat;             % Active damping

CC.H_Order=6;               % Harmonic order of HCC
Kr_ratio = 0.5;
run('GainCal');	% Calculation of controller gains

%% Command setting
Time_Vdc_Ref=0.1;           % Time when dc voltage reference changes
Vdc_Ref=Vdc_OP;           

Time_Pload = 0.1;           % Time when load power changes
Pload=0;%5e3;               % Load power [W]

%% Run simulink
Stop_Time=0.4;
sim('Sim_Ex36_Quiz.slx')
% sim('Sim_Ex36.slx')