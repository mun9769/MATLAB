%%
clear; close all;
A = [1 -1;
     0  2;
    -1  3;];
x=sym('x','real');
y=sym('y','real');
A*[x y]'

%%
clear;

syms theta;

R = [cos(theta) -sin(theta);
    sin(theta) cos(theta)];


%%
% fplot vs plot
% fplot is used for plotting functions defined symbolically or as function handles,
% automatically determining the range and sampling points for smooth curves.
% plot is used for plotting discrete data points or vectors, requiring explicit x and y values.

% Example of fplot
fplot(@(t) cos(t), @(t) sin(t), 'r') % Plots the parametric equations for a circle

% Example of plot
t = linspace(0, 2*pi, 100); % Generate 100 points from 0 to 2*pi
x = cos(t); % x values
y = sin(t); % y values
plot(x, y, 'b') % Plots the circle using discrete points

%%
clear; close all;
theta = pi*2/3;

H=[cos(2*theta) sin(2*theta);
   sin(2*theta) -cos(2*theta)]; % y=ax에 대한 대칭변환.
P=1/2*(H+ eye(2));              % 정사영 변환.

p = [linspace(0,10,50)
    linspace(0,30,50)];
q = P*p;

plot(0, 0, 'ko');
hold on;
axis([-40 40 -40 40]);
pbaspect([1 1 1]);

% Plot the transformed points
plot(q(1,:), q(2,:), 'r.');
plot(p(1,:), p(2,:), 'b.');
grid on;
xlabel('X-axis');
ylabel('Y-axis');
title('Transformed Points');


%%
clear; close all;

Thetar = linspace(-5*pi,5*pi,5*601);
Thetar = wrapToPi(Thetar);

mag = 5;
m1 = mag*cos(Thetar);
m2 = mag*cos(Thetar-2*pi/3);
m3 = mag*cos(Thetar+2*pi/3);

figure;
% main = plot(0, 0, 'ko'); % 없어도 댐.
hold on; grid on;
axis([-10 10 -10 10]);
pbaspect([1 1 1])

aphase = [1 0];
bphase = [cos(2*pi/3) sin(2*pi/3)];
cphase = [cos(4*pi/3) sin(4*pi/3)];
sum = aphase + bphase + cphase;

a = plot([0 aphase(1)], [0 aphase(2)], 'r', 'DisplayName', 'Phase A');
b = plot([0 bphase(1)], [0 bphase(2)], 'g', 'DisplayName', 'Phase B');
c = plot([0 cphase(1)], [0 cphase(2)], 'b', 'DisplayName', 'Phase C');
d = plot([0 sum(1)], [0 sum(2)], 'k-', 'DisplayName', 'sum', 'linewidth', 1.5);

legend([a b c d]); %, 'location', 'best');

for i=1:size(Thetar,2)
    
    sum=[ m1(i)*aphase(1) + m2(i)*bphase(1) + m3(i)*cphase(1);
          m1(i)*aphase(2) + m2(i)*bphase(2) + m3(i)*cphase(2);];

    % Update the phase vector plots
    set(a, 'XData', [0 m1(i)*aphase(1)], 'YData', [0 m1(i)*aphase(2)]);
    set(b, 'XData', [0 m2(i)*bphase(1)], 'YData', [0 m2(i)*bphase(2)]);
    set(c, 'XData', [0 m3(i)*cphase(1)], 'YData', [0 m3(i)*cphase(2)]);
    set(d, 'XData', [0 sum(1)], 'YData', [0 sum(2)]);

    pause(0.005);
    hold off;
end

fprintf("end code\n\n");
