%% vector 그리기
P=[2 3 -1]; 
Q=[1 -2 2];
PQ=Q-P
vectarrow(P,Q)

%%
format short
x=[-7 2];
norm(x)


%% 외적은 3차원에서만 정의
x=[2 -1 1];
y=[1 -2 3];
z=cross(x,y)
norm(z)

%% 부피는 x dot (y cross z)
x=[-3 2 -2];
y=[-1 1 3];
z=[2 -4 3];
T=dot(cross(x,y), z)
V=abs(T)

%% Ax*y = x*A'*y 일단 넘어감.

%%
PQ1=[1 3 -5];
P1= [3 -5 2];
t = sym('t');
x1=P1 + t * PQ1
% syms x y z;
% solve(x==t, t)
% solve(y==1-4*t, t)
% solve(z==7*t-2, t)

%%
x1=[-5 1 2];
x2=[3 -7 1];
x3=[-2 -6 3];
A = [x1' x2' x3'];
[L, U] = lu([x1' x2' x3']);
rref(A)
