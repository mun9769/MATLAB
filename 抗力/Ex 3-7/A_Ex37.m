%% Initialization

clc
clear
close all
format short eng

%% Simulation mode
Mode.Ctrl=2;    
%: 1: Current Control Mode, 2: Voltage Control Mode;
Mode.PWM=1;         % PWM method
% 1: SCPWM, 2: 60deg DPWM, 3: 120deg(on) DPWM, 4: 120deg(off) DPWM
Mode.CC_Type=1;     % Current controller type
% 1: State feedback, % A 2: Complex vector
Mode.NegSeqCC=1;    % Negative sequence current controller
% 0: Off, 1: On
Mode.HCC=1;      % Harmonic current controller
% 0: Off, 1: On
Mode.Pload_FF=0;    % Lower-power feed forward
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

%% Grid voltage setting
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
Vdc_Init=400;               % initial value
Vdc_Oper=400;               % operating point

CC.Wc=300*2*pi;             % Current controller BW
CC.Ra=5*Rs_Hat;             % Active damping

CC.H_Order=6;               % Harmonic order of HCC
Kr_ratio = 0.5;
run('GainCal');	% Calculation of controller gains

%% Command setting
Time_Vdc_Ref=0;             % Time when dc voltage reference changes
Vdc_Ref=Vdc_Oper;

Time_Pload = 0;             % Time when load power changes
Pload=-5e3;                 % Load power [W]
Pload_Hat=1*Pload;          % Estimated load power

Time_PF_Ref=0.1;            % Time when the power factor reference changes
PF_Ref=0.7;

%% Run simulink
Stop_Time=0.3;
sim('Sim_Ex37.slx')

%% Plot 1 - A-phase grid voltage and current
Ind_PF=find(Time > 0.06 & Time < 0.14);
figure(1);
plot(Time, Eabc(:,1), '-k',Time, 5*Iabc(:,1), '-r', 'LineWidth',2);
title('Grid Voltage and Current', 'FontSize',16);
ylabel('Voltage [V] and Current [A]');
xlabel('Time [s]');
xlim([Time(min(Ind_PF)) Time(max(Ind_PF))]);
ylim([-250 250]);
legend('E_a', '5xI_a');
grid on;

%% Plot 2 - Calculated power factor
Ind_PF1=find(Time > 0.05);
figure(2);
plot(Time, PF, '-k', 'LineWidth',2);
title('Calculated Power Factor', 'FontSize',16);
ylabel('Power Factor');
xlabel('Time [s]');
xlim([Time(min(Ind_PF1)) Time(max(Ind_PF1))]);
ylim([0 1.2]);
grid on;
