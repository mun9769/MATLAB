%% 변수분리법

syms x y;
U = dsolve('Dy=y/(x-1)', 'x') % dy/dx = y/(x-1)
latex_U = latex(U);

axis off;
text(0.5, 0.5, ['$$' latex_U '$$'], 'interpreter', 'latex');

%% 변수분리법 2
syms x y;
U = dsolve('x^2*Dy + y^2=0', 'y(1)=1', 'x') % dy/dx = y/(x-1)
latex_U = latex(U);

axis off;
text(0.5, 0.5, ['$$' latex_U '$$'], 'interpreter', 'latex');

%% 변수분리법 3
syms x y;
U = dsolve('Dy+y/x=x*y^2', 'x') % dy/dx = y/(x-1)
latex_U = latex(U);

axis off;
text(0.5, 0.5, ['$$' latex_U '$$'], 'interpreter', 'latex');

%% 1계미방

syms t q;
U = dsolve('4*Dq+2*q=10', 'q(0)=0', 't') % dy/dx = y/(x-1)
latex_U = latex(U);
close all;
axis off;
text(0.5, 0.5, ['$$' latex_U '$$'], 'interpreter', 'latex');
