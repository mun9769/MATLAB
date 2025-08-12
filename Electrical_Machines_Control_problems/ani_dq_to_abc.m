close all; clear;
syms theta_r;

a = 2*pi/3;
global Vd Vq;
Vd = 10/sqrt(3); Vq = 0;

TT = @(theta) ...
    [cos(theta)  cos(theta-a)  cos(theta+a);
    -sin(theta) -sin(theta-a) -sin(theta+a);
    1/2            1/2         1/2;] *2/3;

fig = figure;

[p11, ax1] = my_set_ax1(fig);
[p22] = my_set_ax2(fig);
[p1, p2, p3] = my_set_ax3(fig);


dtheta=1e-2;
cur = 0;

iter = 1000;

for thetar=linspace(0, iter*2*pi, iter*629+1) % 2*pi에 628개

    % V_abc = inv( TT(thetar) ) * [Vd Vq 0]';
    V_abc = TT(thetar) \ [Vd Vq 0]';
    p1.XData(end+1) = cur;    p1.YData(end+1) = V_abc(1);
    p2.XData(end+1) = cur;    p2.YData(end+1) = V_abc(2);
    p3.XData(end+1) = cur;    p3.YData(end+1) = V_abc(3);
    cur = cur + dtheta;

    V_dqs_e = [cos(thetar) -sin(thetar);
               sin(thetar)  cos(thetar)] * [Vd Vq]';
    p22.XData = V_dqs_e(1);
    p22.YData = V_dqs_e(2);


    if(cur >= 8*pi)
        cur = 0;
        p1.XData = []; p1.YData = [];
        p2.XData = []; p2.YData = [];
        p3.XData = []; p3.YData = [];
    end
    % drawnow;
    % saveas(gcf,['.\output\image' num2str(thetar) '.png']); % 사진으로 저장하기
    pause(0)
end


