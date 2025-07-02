clear
syms t;
f=(cos(2*t)+1)/2;
g=t^2+2;
h=(exp(-t)-1)/2;

my_latex(diff(f));
%% sym을 plot
clear
syms t;
x=2*cos(2*t);
y=2*sin(2*t);
fplot(x, y) % plot은 안댐.

pbaspect([1 1 1])

%% 시간에 대해서 plot
clear; close all;

t=0:0.01:3.14;
x=2*cos(2*t);
y=2*sin(2*t);

plot(0, 0, 'ko'); hold on; grid on;
axis([-3 3 -3 3]);
pbaspect([1 1 1]) % 길이 조절

for n=1:length(t)
    plot(x(n),y(n), 'r.', 'linewidth', 1);

    pause(0.01);
end

%% t에 대한 r(t)
clear; close all;

syms t;
x = 2*cos(2*t);
y = 2*sin(2*t);

plot(0, 0, 'ro'); hold on;
axis([-3 3 -3 3]);
fplot(x, y);

rt=[2*cos(2*t) 2*sin(2*t)];
drt = [diff(2*cos(2*t)) diff(2*sin(2*t)) ;];

u1 = subs(drt, t, 0) % drt(0);
u2 = subs(drt, t, pi/4) % drt(pi/4)

%%
clear close all;
syms t;

r1 = [sin(t) cos(t) 0];
r2 = [exp(-t) exp(-t) 0];

r3 = r1*r2';

r4 = diff(r3);

my_latex(r4)

r5 = cross(r1, r2);

r6 = diff(r5);
my_latex(r6);

%%
clear; close all;
t = sym('t', 'real'); % real을 붙여야 conj 배제함.

r1=[ sin(t)  cos(t)];
r2=[exp(-t) exp(-t)];

r3 = r2 * r1';
r4 = diff(r3);

my_latex(r4);

% plot(0, 0, 'ro'); hold on;
% axis([-3 3 -3 3]);

% fplot(r3(1), r3(2));

%%
clear; close all;
t = sym('t', 'real');

r = [3*cos(2*t) 3*sin(2*t)];
dr = diff(r);
dr_m = sqrt(dr(1)^2 + dr(2)^2);
dr_m = simplify(dr_m);

T = dr/dr_m;
dT=diff(T);

dT_m = sqrt(dT(1)^2 + dT(2)^2);
dT_m = simplify(dT_m);

K = dT_m/dr_m;
rho=1/K;

%%
clear; close all;

for n=0:0.1:2*3.14
    
    plot(0, 0, 'ko'); hold on;
    axis([-5 5 -5 5]);
    pbaspect([1 1 1]);

    vectarrow([0 0], [cos(n) sin(n)]);
    pause(0.1)
end
% vectarrow([0 0]', [1 9]);

%% gradient, f가 스칼라임
clear;
x = sym('x', 'real');
y = sym('y', 'real');
z = sym('z', 'real');

f = x^2-x*y*z+2*x*y^2+z^2; % 이건 스칼라구나
fx=diff(f,x);
fy=diff(f,y);
fz=diff(f,z);
gf = [fx fy fz]'

my_latex(gf)
%% 벡터장의 발산, F는 벡터장. divF는 스칼라
% 원통좌표계와 구좌표계에 대해서 미분할 수 있다.
clear
syms x y z;
F1=x*y;
F2=y*z;
F3=x*z;

divF=diff(F1,x)+diff(F2,y)+diff(F3,z)




