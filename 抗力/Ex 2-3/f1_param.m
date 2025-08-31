function [Mode, p, Lamf, Lds, Lqs, Rs, Is_Rated, ...
    Jm, Bm, Vdc, fsw, Tsw, fs, Ts, Lamf_Hat, Rs_Hat, ...
    Lds_Hat, Lqs_Hat, Jm_Hat, Bm_Hat, SpdObs, CC, Thetarm_Init, ...
    Wrm_Init, Wrm_Fin, Idqsr_Ref_Set, Step_Time, Stop_Time] = f1_param()


clc
clear
close all
format short eng

% Simulation mode

Mode.PWM=1;         % PWM method
% 1: SCPWM, 2: 60deg DPWM, 3: 120deg(on) DPWM, 4: 120deg(off) DPWM
Mode.CC_Type=2;     % Current controller type
% 1: State feedback, 2: Complex vector
Mode.AntiWindup=1;  % Anti-windup
% 0: Off, 1: On

% Machine parameters

p=3;                        % # of pole pairs
Lamf=0.254;
Lds=3.6e-3;
Lqs=4.3e-3;
Rs=0.15;
Is_Rated=39.5*sqrt(2);      % Peak Value

Jm=0.01;
Bm=.018;

% System parameters

Vdc = 310;

fsw=10e3;       % Switching frequency
Tsw=1/fsw;      % Switching period

fs=2*fsw;       % Samping frequency (double sampling)
Ts=1/fs;        % Samping period

% Estimated parameters

Lamf_Hat=1.0*Lamf;
Rs_Hat=1.0*Rs;
Lds_Hat=1.0*Lds;
Lqs_Hat=1.0*Lqs;
Jm_Hat=1.0*Jm;
Bm_Hat=1.0*Bm;

% Controller setting

SpdObs.Wn=100*2*pi;         % Speed observer Imag pole
SpdObs.Zeta=1;
SpdObs.P=-1.3*SpdObs.Wn;    % Speed observer real pole

SpdObs.L1=2*SpdObs.Zeta*SpdObs.Wn-SpdObs.P-Bm_Hat/Jm_Hat;
SpdObs.L2=SpdObs.Wn^2-2*SpdObs.Zeta*SpdObs.Wn*SpdObs.P-SpdObs.L1*Bm_Hat/Jm_Hat;
SpdObs.L3=-SpdObs.Wn^2*SpdObs.P;

CC.Wc=500*2*pi;             % Current controller BW
CC.Is_lim=Is_Rated;         % Current constraint
CC.Ra=10*Rs_Hat;            % Active damping

CC.Kp_Mat=CC.Wc*[Lds_Hat 0;0 Lqs_Hat];
CC.Ki_Mat=CC.Wc*(Rs_Hat+CC.Ra)*eye(2);
CC.Ka_Mat=inv(CC.Kp_Mat);

% Command setting

Thetarm_Init=0*pi*1/p;

Wrm_Init=1700*2*pi/60;
Wrm_Fin=1700*2*pi/60;

Idqsr_Ref_Set=[0 -5;0 50];

Step_Time=0.01;
Stop_Time=0.04;




end


