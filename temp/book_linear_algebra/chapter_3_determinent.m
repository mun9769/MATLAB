P=[3 4]; Q = [2 -1];
A=[P;Q];
B=A/det(A);
% B(1,1)^2+B(1,2)^2 % 1 아님
[L, U, P] = lu(A)
det(U)
det(A)
% det(U) 와 det(A)는 같다.

%%
B = [0 1 0 2; 23 82 5 pi; 0 3 0 4; 0 exp(1) 0 2030];
det(B)
[L, U, P] = lu(B)


%%
syms a b;
S=solve(3*a+b==1, -2*a+b==3)
%ezplot('y=-2/5*x+11/5')
%% (7,-9), (-3,8) 두 점을 지나는 직선 방정식 plot
syms x y;
A=[x y 1; 
   7 -9 1; 
   -3 8 1;]
ezplot(det(A), [-10 10 -10 10]);

%% (1, 3), (-4, 4), (2,3)을 지나는 원의 방정식
syms x y;
A=[x^2+y^2 x y 1;
    10 1 3 1; 
    32 -4 4 1; 
    13 2 3 1;]
ezplot(det(A), [-20 20], [0 40]);

%% 5개의 점을 지나는 타원 방정식을 결정해라
syms x y;
[x1, y1] = deal(5.764, 0.648);
[x2, y2] = deal(6.286, 1.202);
[x3, y3] = deal(6.759, 1.823);
[x4, y4] = deal(7.168, 2.526);
[x5, y5] = deal(7.480, 3.360);

A=[x^2 x*y y^2 x y 1;
    x1^2 x1*y1 y1^2 x1 y1 1;
    x2^2 x2*y2 y2^2 x2 y2 1;
    x3^2 x3*y3 y3^2 x3 y3 1;
    x4^2 x4*y4 y4^2 x4 y4 1;
    x5^2 x5*y5 y5^2 x5 y5 1;
    ]
ezplot(det(A))

%% 서로 다른 네 점을 지나는 구의 방정식을 구하라
syms x y z;
[x1, y1, z1] = deal(1, 2, 3);
[x2, y2, z2] = deal(0,-1, 3);
[x3, y3, z3] = deal(2, 2,-3);
[x4, y4, z4] = deal(-2,-3, 4);

A=[
    x^2+y^2+z^2 x y z 1;
    x1^2+y1^2+z1^2 x1 y1 z1 1;
    x2^2+y2^2+z2^2 x2 y2 z2 1;
    x3^2+y3^2+z3^2 x3 y3 z3 1;
    x4^2+y4^2+z4^2 x4 y4 z4 1;
    ]
det(A)
%ezplot(det(A))
fimplicit3(det(A)==0, [-30 10 -10 20 -15 10]);
xlabel('x');ylabel('y');zlabel('z');

%% 네 점을 지나는 3차 보간 다항식을 구하라
syms x y;
[x1, y1] = deal(-1, 3);
[x2, y2] = deal(0, 4);
[x3, y3] = deal(1, 2);
[x4, y4] = deal(3, 6);

A=[ 
    1 x1 x1^2 x1^3 y1;
    1 x2 x2^2 x2^3 y2;
    1 x3 x3^2 x3^3 y3;
    1 x4 x4^2 x4^3 y4;
   ]
rref(A) % 3차식의 계수를 구할 수 있음.
%[L, U] = lu(A)
% det(A)
% ezplot(det(A))


%%
syms a b c;
syms x y z;
syms u v w;
A = [
    a+x b+y c+z;
    x+u y+v z+w;
    u+a v+b w+c;]

det(A)

%%
syms a b c
A=[
    0 c b a;
    c 0 a b;
    b a 0 c;]
rref(A)