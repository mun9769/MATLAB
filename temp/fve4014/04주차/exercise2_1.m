close all;
R = 0.26;
L=1.7e-3;
J=2.52e-3;
B=0;
K=0.4078;

Ki = 0;
Kp = 1;


% 전달함수 정의
s = tf('s'); 
G = K / (L*J*s^2 + R*J*s + K^2);
%%
% Pole-Zero Plot 그리기
figure;
pzmap(G);
title('Pole-Zero Plot');
grid on;

% 극점과 영점 출력
poles = pole(G);
zeros = zero(G);

disp('Poles:');
disp(poles);


% 감쇠비 계산
wn = sqrt(K^2 / (L*J));   % 자연진동수
zeta = (R*J) / (2 * sqrt(K^2 * L * J)); % 감쇠비

if zeta < 1 && zeta > 0
    fprintf("under damping system")
end

%% 4. 시스템을 감쇠비를 바꿀 수 있는 방법과 각각의 장단점에 대해 논하시오.
% 방법1) TL 증가 -> 감쇠비 감소
% 방법2) 새로운 모터 제작 : 비쌈. 원하는 파라미터 생성 가능
% 방법3) 컨트롤러로 보상제어.

%% 5. 전압이 일정할 때 Load torque가 스텝 변화할 때 속도의 응답특성을 논하시오.
