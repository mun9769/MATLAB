
clear; close all;
syms ids iqs
global Vdc P Lds Lqs Lamf to_rps to_rpm w

% fve40 example parameter
P = 24;
Lds = 30e-3;
Lqs = 40e-3;
Lamf = 0.12; % [Wb]
Vdc = 60;
Ismax = 8; % Arms
eDiff = @(eqn) rhs(eqn) - lhs(eqn);

Ls = [Lds 0; 0 Lqs];
J = [0 -1; 1 0];

to_rps = 2*pi/60;
to_rpm = 60/2/pi;

w = 80 * to_rps * P;


[fig, ha, hb] = my_set_sixstep_fig();


hold (ha, 'on');

kk = [-40 40];
quiver(ha, 0, 0, kk(1), kk(2), 'k');

a = 1/w*inv(J)*kk';
a = a - [Lamf 0];
a = inv(Ls) * a;
hold (hb, 'on');

quiver(hb, 0, 0, a(1), a(2), 'k');



    
