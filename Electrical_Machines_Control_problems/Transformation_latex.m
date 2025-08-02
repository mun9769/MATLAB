clear; close all;
syms theta_r;
a = 2*pi/3;

T = [cos(theta_r)  cos(theta_r-a)  cos(theta_r+a);
    -sin(theta_r) -sin(theta_r-a) -sin(theta_r+a);
    1/2            1/2         1/2;] *2/3;
axis off;
text(0, 0.5,['T= ' '$$' latex(T) '$$'], 'interpreter', 'latex');
