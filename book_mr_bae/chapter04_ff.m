clear; close all;
syms Vsmax
syms w Lqs Lds iqs ids phi;
syms Te;

Rot = @(theta) [cos(theta) sin(theta); -sin(theta) cos(theta)];

P = 16;
Lds = 30e-3;
Lqs = 40e-3;
phi = 1;
Vsmax = 400;
iqs = 1;
ids = 0;
w = 100*pi;
Rs = 0.22;
a = 2*pi/3;

eds = -w*Lqs*iqs
eqs =  w*Lds*ids + w*phi
Vds = Rs*ids - w*Lqs*iqs
Vqs = Rs*iqs + w*Lds*ids + w*phi

figure;
hold on; grid on;
axis([-320 320 -320 320]);
pbaspect([1 1 1])
a = -pi/2.6;

eds_plot = quiver(0, 0, eds* cos(a), eds*sin(a), displayname='eds');
eqs_plot = quiver(0, 0, eqs*-sin(a), eqs*cos(a), displayname='eqs');

Vds_plot = quiver(0, 0, Vds* cos(a), Vds*sin(a), 'r', displayname='Vds');
Vqs_plot = quiver(0, 0, Vqs*-sin(a), Vqs*cos(a), 'b', displayname='Vqs');
legend()



