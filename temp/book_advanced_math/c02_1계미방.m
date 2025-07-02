% 식 (3.1) 과 같이 종속변수 y 와 y 의 모든 도함수가 1 차이면서 도함수의 계수가
% 모두 x만의 함수이면 이를 선형이라 하고 , 그렇지 않으면 비선형 nonlincar 이
% 라 한다. 예를 들어 다음 식은 y항이 1차가 아니고 2차이므로 비선형이다
% (d/dx)^2*y + dy/dx = 0;

%%
% 론스키안은 미분가능한 함수들이 정해진 구간 내에서 서로 일차독립함수인지 
% 확인한다.

%% D^2y - 4y = 0의 일반해을 구하라
% 일반해: exp(2x)와 exp(-2x)
% 추가: 론스키안을 통해 두 해가 독립임을 밝힌다.

syms x y;
y1 = exp(2*x); 
y2 = exp(-2*x);
W = [y1 y2;
    diff(y1) diff(y2)];
detW = det(W);

U = dsolve('D2y-4*y=0', 'x')
latex_U = latex(U);
close all;
axis off;
text(0.5, 0.5, ['$$' latex_U '$$'], 'interpreter', 'latex');

%% D2y 관련
clear
U = dsolve('D2y+3*Dy+2*y=cos(x)','x');%, 'y(0)=-1', 'Dy(0)=2', 'x')
latex_U = latex(U);
close all;
axis off;
text(0, 0.5, ['$$' latex_U '$$'], 'interpreter', 'latex');

%% 안댐 미방수식 두개인것.
clear
syms x;
[x, y] = dsolve('Dx=3*x+y, Dy=-x+y ', 'x');
latex_x = latex(x);
latex_y = latex(y);
close all;
axis off;
text(0, 0.5, ['$$' latex_U '$$'], 'interpreter', 'latex');
