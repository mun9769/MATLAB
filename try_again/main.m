clear all;
close all;
clc;

rad2deg = 180/pi;

% 제한사항
% 1. 인버터 안사용
% 2. Ld, Lq는 일정
% 3. 이상적인 아날로그 제어 안함
% 4. 이상적인 전류 센싱.


mm = 2; % 1. 속도+전류 제어 2. 전류제어
Mode = 2; % 2: sensorless

w_h = 2*pi*800;
V_inj = 35;
Stop_Time = 10;
J = 0.045;
B=0.0001;
TL=20;

P = 24;
Rs=2;
Lds = 40.0e-3; %[H] 
Lqs = 20.0e-3; %[H]
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


init_Thetar = 2*pi/7; % theta_r_tilde가 pi/2 넘어가면은 진짜 오류 발생함.

Thetar_hat_init = pi/2; 

wait_time = 0.0;

zeta = 1.2;

%%
G = tf([2*zeta*w_h 0 ], [1 2*zeta*w_h w_h^2]);
nn = w_h * 10;
G = tf([w_h^2], [1 2*zeta*w_h w_h^2]);
bode(G)
%%
out = sim('try_again_agin');

Theta_rhat   =  squeeze (out.logsout.get("Theta_rhat").Values.Data );
Thetar_tilde =  squeeze( out.logsout.get("Thetar_tilde").Values.Data );

tt = out.tout;

figure; hold on;
index = 1:20;
plot(tt(index), Theta_rhat(index), 'ro');

plot(tt(index), Thetar_tilde(index), 'bo');


for ii=2:size(tt, 1)
    assert(Theta_rhat(ii) == Theta_rhat(ii-1) + Thetar_tilde(ii), "hawing");
    Theta_rhat(ii)
end

sum = 0;
for ii=2:size(tt,1)
    sum = sum + Thetar_tilde(ii);
end

sum

%%
G = tf([1 0], [1 w_h/10]);



margin(G)