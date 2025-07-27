%% Initialization

clc
clear
close all
format short eng

%% Simulation mode

Mode.PWM=1;         % PWM method
% 1: SCPWM, 2: 60deg DPWM, 3: 120deg(on) DPWM, 4: 120deg(off) DPWM
Mode.CC_Type=2;     % Current controller type
% 1: State feedback, 2: Complex vector
Mode.SC_Type=1;     % Speed controller type
% 1: PI controller, 2: IP controller
Mode.AntiWindup=1;  % Anti-windup
% 0: Off, 1: On
Mode.FW=1;  % Flux-weakening method
% 0: Off, 1: On

%% Machine parameters

p=3;                        % # of pole pairs
Lamf=0.254;
Lds=3.6e-3;
Lqs=4.3e-3;
Rs=0.15;
Is_Rated=39.5*sqrt(2);      % Peak Value

Jm=0.01;
Bm=.018;

%% System parameters

Vdc = 310;

fsw=10e3;       % Switching frequency
Tsw=1/fsw;      % Switching period

fs=2*fsw;       % Samping frequency (double sampling)
Ts=1/fs;        % Samping period

%% Estimated parameters

Lamf_Hat=1.0*Lamf;
Rs_Hat=1.0*Rs;
Lds_Hat=1.0*Lds;
Lqs_Hat=1.0*Lqs;
Jm_Hat=1.0*Jm;
Bm_Hat=1.0*Bm;

%% MTPA curve calculation

MTPA.Is=linspace(-3*Is_Rated,3*Is_Rated,1001);
if Lds_Hat~=Lqs_Hat
    MTPA.Idsr=(Lamf_Hat-sqrt(8*(Lds_Hat-Lqs_Hat)^2*MTPA.Is.^2+Lamf_Hat^2))/(-8*(Lds_Hat-Lqs_Hat));
    MTPA.Iqsr=sign(MTPA.Is).*sqrt(MTPA.Is.^2-MTPA.Idsr.^2);
else
    MTPA.Idsr=-500*eps:eps:500*eps;
    MTPA.Iqsr=MTPA.Is;
end
MTPA.Te=3/2*p*(Lamf*MTPA.Iqsr+(Lds-Lqs)*MTPA.Idsr.*MTPA.Iqsr);

Ind_PosTe=find(MTPA.Te>=0);
Te_Rated=interp1(MTPA.Is(Ind_PosTe),MTPA.Te(Ind_PosTe),Is_Rated);

%% Controller setting

% Current controller
CC.Wc=500*2*pi;             % Current controller BW
CC.Is_lim=Is_Rated;         % Current constraint
CC.Ra=10*Rs_Hat;            % Active damping

CC.Kp_Mat=CC.Wc*[Lds_Hat 0;0 Lqs_Hat];
CC.Ki_Mat=CC.Wc*(Rs_Hat+CC.Ra)*eye(2);
CC.Ka_Mat=inv(CC.Kp_Mat);

% Flux weakening
FW.Vs_lim=0.55*Vdc;         % Voltage limit for FW controller

FW.Kp=0.002;
FW.Ki=50;
FW.Ka=200;

% Speed controller
SC.Wc=20*2*pi;              % Speed controller BW
SC.Zeta=0.707;
SC.Te_lim=1.0*Te_Rated;     % Torque limit for Speed controller

SC.Kp=Jm_Hat*SC.Wc;
SC.Ki=SC.Kp*SC.Wc/5;
SC.Ka=2/SC.Kp;

%% Command setting

Thetarm_Init=0*pi*1/p;

% Speed command
Wrpm_Ref_Set=[0 100];
Wrm_Init=2*pi/60*Wrpm_Ref_Set(1);

% Load torque disturbance
TL=zeros(1,2)*Te_Rated;

% Command Timing
Step_Time=0.02;
Stop_Time=0.2;

%% Run Simulink

sim('Sim_Ex26.slx')

