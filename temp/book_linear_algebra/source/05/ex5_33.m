u1=[2 -1 0];u2=[1 2 5/2];u3=[-1 -2 2];          % 벡터 입력
d12=dot(u1,u2),d23=dot(u2,u3),d31=dot(u3,u1)    % 벡터들의 직교성 확인
v1=1/norm(u1)*u1;                               % 주어진 벡터의 정규화
v2=1/norm(u2)*u2;
v3=1/norm(u3)*u3;
n1=norm(v1),n2=norm(v2),n3=norm(v3)             % 벡터의 크기 계산