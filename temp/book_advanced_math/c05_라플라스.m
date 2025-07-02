
clear
syms t;
y=2*exp(2*t-1);
y=sin(t+pi/6);
y=exp(-t)*(t-1);
y=int(exp(-t),0,t);

U = laplace(y);

latex_U = latex(U);
close all;
axis off;
text(0, 0.5, ['$$' latex_U '$$'], 'interpreter', 'latex');

%% f(t)는 f와 t의 변수,,
clear
syms f(t);
v=diff(f(t));
U = laplace(v)
%% 역라플라스
clear
syms s;
F=(s+1)/(s^3+s);
y=ilaplace(F);


latex_y = latex(y);
close all; axis off;
text(0, 0.5, ['$$' latex_y '$$'], 'interpreter', 'latex');

%% 문제풀이
clear
syms s x0 xp0 wn; % p는 미분인자를 의미.
Xs=(s*x0+xp0)/(s^2+wn^2);
xt=ilaplace(Xs);

latex_xt = latex(xt);
close all; axis off;
text(0, 0.8, ['$$' latex_xt '$$'], 'interpreter', 'latex');


