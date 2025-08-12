clear;

a = 2*pi/3;
global Vd Vq;
Vd = 10/sqrt(3); Vq = 0;

TT = @(theta) ...
    [cos(theta)  cos(theta-a)  cos(theta+a);
    -sin(theta) -sin(theta-a) -sin(theta+a);
    1/2            1/2         1/2;] *2/3;

fig = figure;

[p11, ax1] = my_set_ax1(fig);
% [p22] = my_set_ax2(fig);
[p1, p2, p3] = my_set_ax3_new(fig);

r = 10/sqrt(3);
rot = [cos(pi/2) -sin(pi/2); sin(pi/2) cos(pi/2)];
sf = 1.8;

vidObj = VideoWriter('gogo', 'MPEG-4');
open(vidObj);
dtheta=1e-2;


for t=linspace(-pi/2, pi/2, 10)

    Vd = r*cos(t);
    Vq = r*sin(t);
    kkk = rot*[Vd Vq]';


    q=quiver(ax1, 0,0, Vd*sf, Vq*sf, 'k--');
    q2 = quiver(ax1, 0,0, kkk(1)*sf, kkk(2)*sf, 'k--');
    cur = 0;
    kk = linspace(0,10*pi, 100);
    for zz = kk
        aa = Vd*cos(zz);
        bb = Vq*cos(zz);

        V_abc = TT(0) \ [aa bb 0]';
        p1.XData(end+1) = cur;    p1.YData(end+1) = V_abc(1);
        p2.XData(end+1) = cur;    p2.YData(end+1) = V_abc(2);
        p3.XData(end+1) = cur;    p3.YData(end+1) = V_abc(3);
        cur = cur + dtheta;

        set(p11, 'XData', aa, 'YData', bb);

        currFrame = getframe(fig);
        writeVideo(vidObj, currFrame);

        if zz == kk(end)
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


