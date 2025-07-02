u1=[2 -1 0];u2=[1 2 5/2];u3=[-1 -2 2];  % 직교기저 입력
v1=1/norm(u1)*u1;                       % 벡터의 정규화
v2=1/norm(u2)*u2;
v3=1/norm(u3)*u3;
syms c1 c2 c3                           % 심볼릭 변수 지정
x=[-1 2 1];                             % 벡터 입력
S=solve(x==c1*v1+c2*v2+c3*v3); 
Sol=[S.c1, S.c2, S.c3]
c1=dot(x,v1),c2=dot(x,v2),c3=dot(x,v3)  % 벡터의 직교성 확인