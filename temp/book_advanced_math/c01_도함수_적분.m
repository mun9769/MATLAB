syms x;
f=x/sin(2*x);
%U=limit(f,2)

close all;

fplot(f, 'LineWidth', 2);
xlabel('x');
ylabel('f(x)');
title('Plot of f(x)');
grid on;

%%
U = diff(f)
latex_f = latex(f)

close all

axis off;
text(0, 0.5, ['$$' latex_f '$$'], 'Interpreter', 'latex')


%% 도함수 출력하기
syms x;
y = 2^x*sin(x)/(exp(x)+1);
yh = diff(y);
latex_yh=latex(yh);

close all;
axis off;
text(0, 0, ['$$' latex_yh '$$'], 'interpreter', 'latex')

%% 적분하기
clear
syms x;
%y = exp(-x^2);
y = exp(2*x)*cos(2*x);
y_int = int(y);

close all;
latex_y_int = latex(y_int);
axis off;
text(0, 0.5, ['$$' latex_y_int '$$'], 'Interpreter', 'latex');


