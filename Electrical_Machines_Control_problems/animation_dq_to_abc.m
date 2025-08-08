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
[p1, p2, p3] = my_set_ax3(fig);


theta = linspace(0,8*pi, 629);
idx = 1;
for ii=theta
    VV = TT(ii) \ [Vd Vq 0]';
    V_abc(idx,:) = VV;
    idx = idx + 1;
end

p1.XData = theta; p2.XData = theta; p3.XData = theta;
p1.YData = V_abc(:,1);
p2.YData = V_abc(:,2);
p3.YData = V_abc(:,3);

r = 10/sqrt(3);
rot = [cos(pi/2) -sin(pi/2); sin(pi/2) cos(pi/2)];
sf = 1.8;

vidObj = VideoWriter('gogo', 'MPEG-4');
open(vidObj);

for t=linspace(-pi/2, pi/2, 10)

    Vd = r*cos(t);
    Vq = r*sin(t);
    
    kkk = rot*[Vd Vq]';

    q=quiver(ax1, 0,0, Vd*sf, Vq*sf, 'k--');
    q2 = quiver(ax1, 0,0, kkk(1)*sf, kkk(2)*sf, 'k--');

    set(p11, 'XData', Vd, 'YData', Vq);
    idx = 1;
    for ii=theta
        VV = TT(ii) \ [Vd Vq 0]';
        V_abc(idx,:) = VV;
        idx = idx + 1;
    end
    p1.YData = V_abc(:,1);
p2.YData = V_abc(:,2);
p3.YData = V_abc(:,3);
for iii = 1:100
    currFrame = getframe(fig);
    writeVideo(vidObj, currFrame);
end
pause(0);
delete(q);
delete(q2);
end
close(vidObj);

%%

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


