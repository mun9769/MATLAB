
C = 1/500;
Kp = 1;
Ki = 1;

T = tf([1 0], [C Kp Ki*Kp]);

% Bode plot 핸들 생성 및 위상 숨기기
figure; hold on;
title('Blue Line: Kp=1, Ki=1, C=2mF');

h = bodeplot(T);
setoptions(h, 'PhaseVisible', 'off');
%
Kp = 20;
T = tf([1 0], [C Kp Ki*Kp]);
h2 = bodeplot(T);
setoptions(h2, 'phasevisible', 'off')

Kp=20; Ki=20;
T = tf([1 0], [C Kp Ki*Kp]);
h3 = bodeplot(T);
setoptions(h3, 'phasevisible', 'off')



% 범례 추가 (Line 핸들을 직접 추출)
ax = findobj(gcf, 'Type', 'axes');  % Bode 플롯의 axes 찾기
lines = findobj(ax, 'Type', 'line'); % 모든 라인 객체 찾기
set(lines, 'LineWidth', 3); % 모든 라인 객체의 LineWidth 설정

% 범례 설정 (순서 확인 필요)
legend(lines(end:-1:1), {'Kp=1, Ki=1', 'Kp=20, Ki=1', 'Kp=20, Ki=20'});  % 라인 순서에 주의!


