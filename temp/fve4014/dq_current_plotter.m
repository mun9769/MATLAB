clear
close all;
f = 60;          % 주파수 (Hz)
dt=0.00025;      % 샘플링 주파수 (s)
duration = 1/60 * 6;   % 신호 지속 시간 (초)

% 시간 벡터 생성
t = 0:dt:duration;

% 120도 위상 차이 (2π/3 라디안)
phase_shift = 2*pi/3;

% 3상 코사인 신호 생성
cos1 = cos(2*pi*f*t);              % 위상 0도 (기준)
cos2 = cos(2*pi*f*t - phase_shift); % 위상 -120도
cos3 = cos(2*pi*f*t + phase_shift); % 위상 +120도


T = 2/3*[1 -1/2 -1/2; 0 sqrt(3)/2 -sqrt(3)/2; 0.5 0.5 0.5];
fabcs = [cos1; cos2; cos3];
fdqs = T * fabcs;

w = 2*pi*f;
theta = w*t;

fdqse = s2e(theta,fdqs);

R = [{cos(theta)} {-sin(theta)}; {sin(theta)} {cos(theta)}; ];
% 행렬식 계산 (벡터화)
det_R = R{1,1} .* R{2,2} - R{1,2} .* R{2,1};

% 역행렬 저장
R_inv = {
    R{2,2} ./ det_R,  -R{1,2} ./ det_R;
   -R{2,1} ./ det_R,   R{1,1} ./ det_R
};

%%
figure;

% 서브플롯 1: cos1, cos2, cos3
subplot(3,1,1)
h1 = plot(t(1), cos1(1), 'r', 'DisplayName', 'fas', 'LineWidth', 1.5); hold on;
h2 = plot(t(1), cos2(1), 'g', 'DisplayName', 'fbs', 'LineWidth', 1.5);
h3 = plot(t(1), cos3(1), 'b', 'DisplayName', 'fcs', 'LineWidth', 1.5); hold off;
legend('show');
axis([0 duration -1.5 1.5]);
title('3-phase signals');

% 서브플롯 2: fdqs
subplot(3,1,2)
h4 = plot(t(1), fdqs(1,1), 'r', 'DisplayName', 'fds', 'LineWidth', 1.5); hold on;
h5 = plot(t(1), fdqs(2,1), 'b', 'DisplayName', 'fqs', 'LineWidth', 1.5); hold off;
legend('show');
axis([0 duration -1.5 1.5]);
title('DQ components');


subplot(3,1,3)
h8 = plot(t(1), fdqse(1,1), 'r', 'displayname', 'fde', 'LineWidth', 1.5); hold on;
h9 = plot(t(1), fdqse(1,1), 'b', 'displayname', 'fqe', 'LineWidth', 1.5); hold off;
axis([0 duration -1.5 1.5]);
legend('show');
title('fde, fqe');



% 애니메이션 루프
for i = 1:length(t)
    % 서브플롯 1 업데이트
    set(h1, 'XData', t(1:i), 'YData', cos1(1:i));
    set(h2, 'XData', t(1:i), 'YData', cos2(1:i));
    set(h3, 'XData', t(1:i), 'YData', cos3(1:i));

    % 서브플롯 2 업데이트
    set(h4, 'XData', t(1:i), 'YData', fdqs(1,1:i));
    set(h5, 'XData', t(1:i), 'YData', fdqs(2,1:i));
    % 
    % % 서브플롯 3 업데이트
    % set(h6, 'XData', t(1:i), 'YData', cos1(1:i));
    % set(h7, 'XData', t(1:i), 'YData', fdqs(1,1:i));


    % 서브플롯 2 업데이트
    set(h8, 'XData', t(1:i), 'YData', fdqse(1,1:i));
    set(h9, 'XData', t(1:i), 'YData', fdqse(2,1:i));

    % 그래프 업데이트
    drawnow;

    pause(0.0);
end




