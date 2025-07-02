
%% 시간에 대해서 plot
clear; close all;

t=0:0.01:3.14;

x=2*cos(2*t);
y=2*sin(2*t);

plot(0, 0, 'bo'); hold on; grid on;
axis([-3 3 -3 3]);
pbaspect([1 1 1]) % 길이 조절

for n=1:length(t)
    plot(x(n),y(n), 'r.', 'linewidth', 1);

    pause(0.01);
end


%%
clear; close all;

Thetar = linspace(-5*pi,5*pi,5*601);
Thetar = wrapToPi(Thetar);

mag = 5;
m1 = mag*cos(Thetar);
m2 = mag*cos(Thetar-2*pi/3);
m3 = mag*cos(Thetar+2*pi/3);

figure;
% main = plot(0, 0, 'ko');
hold on; grid on;
axis([-10 10 -10 10]);
pbaspect([1 1 1]);

aphase = [1 0];
bphase = [cos(2*pi/3) sin(2*pi/3)];
cphase = [cos(4*pi/3) sin(4*pi/3)];
sum = aphase + bphase + cphase;

a = plot([0 aphase(1)], [0 aphase(2)], 'r', 'DisplayName', 'Phase A');
b = plot([0 bphase(1)], [0 bphase(2)], 'g', 'DisplayName', 'Phase B');
c = plot([0 cphase(1)], [0 cphase(2)], 'b', 'DisplayName', 'Phase C');
d = plot([0 sum(1)], [0 sum(2)], 'k--', 'DisplayName', 'sum', 'linewidth', 2);

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

% todo) arrow: plot 대신 quiver.
% quiver(0, 0, V(1,1), V(2,1), 'r', 'LineWidth', 2);
% quiver(0, 0, V(1,2), V(2,2),