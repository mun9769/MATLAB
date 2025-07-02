clear all;
close all;
clc;

Stop_Time = 10;
J = 0.045;
B=0.0001;
TL=20;

P = 24;
Rs=2;
Lds = 30.0e-3; %[H] 
Lqs = 30.0e-3; %[H]
Lamf = 0.12; %[Wb]

Wrpm_rated = 400;
Te_rated = 20;

Is_rated = 4.5;

Wrm_rated = Wrpm_rated *2*pi/60;
Wr_rated = Wrm_rated*P;

