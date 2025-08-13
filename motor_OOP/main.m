clear all;
close all;
clc;

% 제한사항
% 1. 인버터 없이. 
% 2. Lds, Lqs는 상수. 

% saturation 넣어야? 
% 이상적인 전류 센싱 
% 디지털 제어는 없음. 

% theta_r_tilde가 90도가 안된다고 가정. sin(2*theta_r_tilde) = 0이 되도록하는 것.

Mode = 1; % 1: speed feedback, 2: sensorless

V_inj = 60;
w_h = 2*pi*1000;
rad2deg = 180/pi;

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



%%

G = tf([1 0], [1 w_h]);

margin(G)


