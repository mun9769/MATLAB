clear all;
close all;
clc;
rad2deg = 180/pi;

mm = 2; % 1. 속도+전류 제어 2. 전류제어

Mode = 2; % 2: sensorless
w_h = 2*pi*800;
V_inj = 60;

Stop_Time = 10;
J = 0.045;
B=0.0001;
TL=20;

P = 24;
Rs=2;
Lds = 30.0e-3; %[H] 
Lqs = 40.0e-3; %[H]
Lamf = 0.12; %[Wb]

Wrpm_rated = 400;
Te_rated = 20;

% Is_rated = 4.5;
Is_rated = 10;

Wrm_rated = Wrpm_rated *2*pi/60;
Wr_rated = Wrm_rated*P;


Wcc = 100*2*pi;
Kpc = Lds*Wcc;
Kic = Rs*Wcc;


Kt = 1.5*P*Lamf;
Wsc=2*pi*5;
Kps=J*Wsc/Kt;
Kis=J*Wsc^2/5/Kt;
Kas=1/Kps;

Vsmax = 60;



