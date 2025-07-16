close all; clear;
syms theta_r;
a = 2*pi/3;

global Vd Vq;
Vd = 10;
Vq = 0;

TT = @(theta) ...
    [cos(theta)  cos(theta-a)  cos(theta+a);
    -sin(theta) -sin(theta-a) -sin(theta+a);
    1/2            1/2         1/2;] *2/3;


fig = figure;
li = zeros(2,6);
for i=1:7
    li(1,i) = 10 * cos(i*pi/3);
    li(2,i) = 10 * sin(i*pi/3);
end

% 첫 번째 서브플롯 (좌클릭 영역)
ax1 = subplot(1, 100, 1:40);
axis(ax1, [-12 12 -12 12]);
pbaspect(ax1, [1 1 1]);
grid(ax1, 'on'); hold(ax1, 'on');
xlabel(ax1, 'V_d^r'); ylabel(ax1, 'V_q^r');
title(ax1, '마우스로 좌표 클릭(station frame 아님 주의)');
plot(ax1, li(1,:), li(2,:), 'k-')

% 두 번째 서브플롯 (좌표 출력 영역)
ax2 = subplot(1, 100, 41:50);
axis(ax2, 'off'); % 축 숨기기
% title(ax2, '클릭 좌표');
coord_text = text(ax2, 0.1, 0.5, '', 'FontSize', 12);
p1 = plot(ax1, Vd, Vq, 'ro', 'MarkerSize', 8);

% 마우스 클릭 이벤트 설정
set(fig, 'WindowButtonDownFcn', @(src,event) onClick(ax1, coord_text, p1));


ax3 = subplot(1, 100, 51:100);
axis(ax3, 'off');

% -- 2. ax3 내부에 3x1 서브플롯 생성 --
pos = get(ax3, 'Position'); % [x, y, width, height]

% 3x1 서브플롯 간격 설정
gap = 0.08; % 서브플롯 사이의 간격
h = (pos(4) - 2*gap) / 3; % 각 서브플롯 높이

% 내부 axes 생성
ax3_1 = axes('Position', [pos(1), pos(2)+2*h+2*gap, pos(3), h]);
ax3_2 = axes('Position', [pos(1), pos(2)+h+gap, pos(3), h]);
ax3_3 = axes('Position', [pos(1), pos(2), pos(3), h]);

xlim = 8*pi; ylim = 18;
title(ax3_1, 'V_a');
title(ax3_2, 'V_b');
title(ax3_3, 'V_c');

hold(ax3_1, 'on');
hold(ax3_2, 'on');
hold(ax3_3, 'on');

xticks(ax3_1, [2*pi, 4*pi, 6*pi, 8*pi]);
xticklabels(ax3_1, {'2\pi', '4\pi', '6\pi', '8\pi'});
xticks(ax3_2, [2*pi, 4*pi, 6*pi, 8*pi]);
xticklabels(ax3_2, {'2\pi', '4\pi', '6\pi', '8\pi'});
xticks(ax3_3, [2*pi, 4*pi, 6*pi, 8*pi]);
xticklabels(ax3_3, {'2\pi', '4\pi', '6\pi', '8\pi'});

axis(ax3_1, [0 xlim -ylim ylim])
axis(ax3_2, [0 xlim -ylim ylim])
axis(ax3_3, [0 xlim -ylim ylim])


p1 = plot(ax3_1, 0, 0, 'color', 'r');
p2 = plot(ax3_2, 0, 0, 'color', 'b');
p3 = plot(ax3_3, 0, 0, 'color', 'g');

dtheta=1e-2;
cur = 0;

iter = 1000;

for thetar=linspace(0, iter*2*pi, iter*629+1) % 2*pi에 628개
    % wr은 몇이지? 내가 정해줄수가 없나
    V_abc = inv( TT(thetar) ) * [Vd Vq 0]';
    p1.XData(end+1) = cur;    p1.YData(end+1) = V_abc(1);
    p2.XData(end+1) = cur;    p2.YData(end+1) = V_abc(2);
    p3.XData(end+1) = cur;    p3.YData(end+1) = V_abc(3);
    cur = cur + dtheta;

    if(cur >= 8*pi)
        cur = 0;
        p1.XData = []; p1.YData = [];
        p2.XData = []; p2.YData = [];
        p3.XData = []; p3.YData = [];
    end
    pause(0.002)
end



function onClick(ax1, coord_text, p1)
    global Vd Vq
    pt = get(ax1, 'CurrentPoint');
    Vd = pt(1,1);
    Vq = pt(1,2);
    
    % 첫 번째 서브플롯에 점 표시
    set(p1, 'XData', Vd, 'YData', Vq);

    % 두 번째 서브플롯에 좌표 업데이트
    new_text = sprintf('[%.1f, %.1f]\n', Vd, Vq);
    set(coord_text, 'String', new_text);
    
end


