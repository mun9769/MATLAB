close all;
clear;
R = 0.26;
L=1.7e-3;
J=2.52e-3;
B=0;
K=0.4078;

Ki = 0.5;
Kp = 1;


% 전달함수 정의
s = tf('s'); 
G = K / (L*J*s^2 + R*J*s + K^2);

%%
zeta = 0.707;
wn = 2*pi*350;
Ww = 60;
out = sim('exercise2_1.slx');
Wrm =     squeeze(out.logsout.get("Wrm").Values.Data );
Wrm_Ref = squeeze(out.logsout.get("Wrm_Ref").Values.Data );
%TL =      squeeze(out.logsout.get("TL").Values.Data );


%%
clear
C = 1e-6;
Kp=0.1;
Ki=0.8;
G = tf(1, [C 0]);
Gc = tf([Kp Ki], [1 0]);
T = feedback(G, Gc);
margin(T);

%%
title("0.1 + 0.8/s bode plot")