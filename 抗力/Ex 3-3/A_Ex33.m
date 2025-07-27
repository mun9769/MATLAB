%% Initialization

clc
clear
close all
format short eng

%% BW comparision mode
BW_Comp=0;
% 0: Bandwidth comparison off, 1: Bandwidth comparison on

%% Grid parameters in normal condition
Grid.V=220;                             % Grid voltage, line-to-line RMS value, [V]
Grid.We=2*pi*60;                        % Frequency, [rad/s]  
Grid.Thetae_Init=pi/180*0;              % Initial angle, [rad]

%% Grid parameters in fault condition
Grid.Time_Fault = 0.02;                     % Time when the fault is occurred

                                            % Positive sequence
Grid.Ratio_P=2/3;                           % Magnitude ratio

                                            % Negative sequence
Grid.Ratio_N=1/3;                           % Magnitude ratio
Grid.Thetae_N_Init=pi/180*90;               % Initial angle

                                            % 5th harmonic
Grid.Ratio_5th=0.2;                         % Magnitude ratio
Grid.Thetae_5th_Init=pi/180*90;             % Initial angle

                                            % 7th harmonic
Grid.Ratio_7th=0.14;                        % Magnitude ratio
Grid.Thetae_7th_Init=pi/180*90;             % Initial angle

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
PLL.K_SOGI=1/sqrt(2);       % SOGI k-factor
E=Grid.V_P;                 % Grid phase voltage peak value

PLL.Kp=2*PLL.Zeta*PLL.Wn/E;
PLL.Ki=PLL.Wn^2/E;

%% BW comparision & Plots - Angle error convergence dynamics comparison
if(BW_Comp==1)
    
    Stop_Time=1;
    PLL.Wn=2*pi*5;
    Enable_XY_Plot=0;
    K_SOGI=[2; 1/sqrt(2); 0.2];
    for i = 1:3                                 % Run Sim. 3 times with different k_SOGI values
        PLL.K_SOGI=K_SOGI(i);                   % to compare the dynamic response
        sim('Sim_Ex33.slx');
        Thetae_Err_Comp(:,i)=Thetae_Err;
        Time_Comp=Time;
    end

    
    Ind2=find(Time_Comp > 0);    %
    figure(1);
    plot(Time_Comp(Ind2), Thetae_Err_Comp(Ind2,1), '-b',Time_Comp(Ind2), Thetae_Err_Comp(Ind2,2), '-r',Time_Comp(Ind2), Thetae_Err_Comp(Ind2,3), '-k', 'LineWidth',2);
    a=title('Angle Error, $\theta_e$ -  $\hat{\theta}_{e}$','FontSize',16);
    set(a, 'Interpreter', 'latex');
    xlabel('Time [s]');
    ylabel('Angle [\circ]');
    xlim([0 1]);
    ylim([-2 2.5])
    legend('k = 2', 'k = 1/\surd2', 'k = 0.2');
    grid on;
end

%% Run simulink
Stop_Time=0.12;
PLL.K_SOGI=1/sqrt(2);
PLL.Wn=2*pi*5;
PLL.Kp=2*PLL.Zeta*PLL.Wn/E;
PLL.Ki=PLL.Wn^2/E;  
Enable_XY_Plot=1;
sim('Sim_Ex33.slx')

