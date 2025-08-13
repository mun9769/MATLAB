clear;

a = 2*pi/3;
global Vd Vq;
Vd = 10/sqrt(3); Vq = 0;
w_h = 2*pi*3000;
xlim=10e-3;

TT = @(theta) ...
    [cos(theta)  cos(theta-a)  cos(theta+a);
    -sin(theta) -sin(theta-a) -sin(theta+a);
    1/2            1/2         1/2;] *2/3;

fig = figure;

[p11, ax1]   = plot_ax1_Vdqse(fig);
[p1, p2, p3] = plot_ax3_Vabc_versus_time(fig, xlim);

r = 10/sqrt(3);
rot = [cos(pi/2) -sin(pi/2); sin(pi/2) cos(pi/2)];
sf = 1.8;

vidObj = VideoWriter('gogo', 'MPEG-4');
open(vidObj);

cur=0;
for t=linspace(-pi/2, pi/2, 10)

    Vd = r*cos(t);
    Vq = r*sin(t);
    d_axis = [Vd Vq]'*sf;
    q_axis = rot*[Vd Vq]'*sf;

    q =quiver(ax1, 0,0, d_axis(1), d_axis(2), 'k--');
    q2=quiver(ax1, 0,0, q_axis(1), q_axis(2), 'k--');

    prv = 0;

    for zz = linspace(0, 6*pi, 100)
        tt = zz/w_h;
        dt = tt - prv;
        cur = cur + dt;
        prv = tt;

        pos = cos(zz) * [Vd Vq 0]';

        V_abc = TT(0) \ pos;
        p1.XData(end+1) = cur;    p1.YData(end+1) = V_abc(1);
        p2.XData(end+1) = cur;    p2.YData(end+1) = V_abc(2);
        p3.XData(end+1) = cur;    p3.YData(end+1) = V_abc(3);

        set(p11, 'XData', pos(1), 'YData', pos(2));

        currFrame = getframe(fig);
        writeVideo(vidObj, currFrame);

        if cur >=xlim
            cur = 0;
            p1.XData = []; p1.YData = [];
            p2.XData = []; p2.YData = [];
            p3.XData = []; p3.YData = [];
        end
    end
    pause(0);
    delete(q);
    delete(q2);
end
close(vidObj);


