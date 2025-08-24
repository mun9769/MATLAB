clear all;
close all;
clc;

rad2deg = 180/pi;

mm = 2; % 1. 속도+전류 제어 2. 전류제어
Mode = 2; % 2: sensorless

V_inj = 35;
Stop_Time = 10;
J = 0.045;
B=0.0001;
TL=20;

P = 8;
Rs=2;
Lds = 30.0e-3; %[H] 
Lqs = 40.0e-3; %[H]

Ls = 30.0e-3; % todo: remove Lds, Lqs 
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


init_Thetar = 20 *(pi/180); % theta_r_tilde가 pi/2 넘어가면은 진짜 오류 발생함.

Thetar_hat_init = 0;%3*pi/7; 

wait_time = 0.0;

zeta = 0.8;

if 1
    w_h = 2*pi*800;
    K = 2.1; % 2.6;
    step_time = 1e-4;

    out = sim('sensorless_by_estimated_rotate');
else
    w_h = 2*pi*5000; % 전향보상하니까 훨씬 좋네
    K = 2.6;    
    out = sim('sensorless_by_torque');
end


