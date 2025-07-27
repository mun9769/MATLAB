%% Initialization

clc
clear
close all
format short eng

%% Simulation mode

Mode.PWM=1;         % PWM method
% 1: SCPWM, 2: 60deg DPWM, 3: 120deg(on) DPWM, 4: 120deg(off) DPWM
Mode.CC_Type=2;     % Current controller type
% 1: State feedback, % A 2: Complex vector
Mode.NegSeqCC=0;    % Negative sequence current controller
% 0: Off, 1: On
Mode.HCC=0;      % Harmonic current controller
% 0: Off, 1: On
FFT_Analysis=0;     % FFT analysis of grid current before/after HCC turn on
                    
%% Grid parameters in normal condition
Grid.V=220;                             % Grid voltage, line-to-line RMS value, [V]
Grid.We=2*pi*60;                        % Frequency, [rad/s]  
Grid.Thetae_Init=pi/180*0;              % Initial angle, [rad]

%% Grid parameters in fault condition
Grid.Time_Fault = 0.1;                  % Time when the fault is occurred

                                        % Positive sequence
Grid.Ratio_P=1;                         % Magnitude ratio

                                        % Negative sequence
Grid.Ratio_N=0;%1/3;                         % Magnitude ratio
Grid.Thetae_N_Init=pi/180*90;           % Initial angle

                                        % 5th harmonic
Grid.Ratio_5th=0.2;                     % Magnitude ratio
Grid.Thetae_5th_Init=pi/180*0;          % Initial angle

                                        % 7th harmonic
Grid.Ratio_7th=0.14;                    % Magnitude ratio
Grid.Thetae_7th_Init=pi/180*0;          % Initial angle

%% Grid voltage setting
Grid.V_B=Grid.V*sqrt(2/3);              % Voltage base
                                        % Phase & peak value

Grid.V_P=Grid.V_B;         
Grid.V_N=Grid.Ratio_N*Grid.V_B;
Grid.V_5th=Grid.Ratio_5th*Grid.V_B;
Grid.V_7th=Grid.Ratio_7th*Grid.V_B;


%% System parameters
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
Vdc_Init=450;               % initial value
Vdc_Oper=450;               % operating point

CC.Wc=300*2*pi;             % Current controller BW
CC.Ra=5*Rs_Hat;             % Active damping

CC.H_Order=6;               % Harmonic current controller 
Kr_ratio = 0.5;


run('GainCal');	% Calculation of controller gains
CC.Kr=Kr_ratio*CC.Ki;
%% Command setting
Time_CC_Ref=0.04;
CC.Ide_Ref=10;
CC.Iqe_Ref=-20;

%% Run simulink
Stop_Time=0.2;
if(FFT_Analysis==0)
    sim('Sim_Ex35.slx')
else
    Mode.HCC=0;
    sim('Sim_Ex35.slx')
    I_HCC_Off=Iabc;
    Mode.HCC=1;
    sim('Sim_Ex35.slx')
    I_HCC_On=Iabc;
    run('Current_FFT');
end