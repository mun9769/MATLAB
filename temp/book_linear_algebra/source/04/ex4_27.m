syms x y z                          % 심볼릭 변수 지정
X=[x y z];P=[-5 7 1];n=[2 -3 4];    % [예제 4-27(a)]의 벡터 지정
dot(n,X-P)                          % 식 (4.15) 계산
X=[x y z];P=[0 -3 5];n=[2 0 4];     % [예제 4-27(b)]의 벡터 지정
dot(n,X-P)
P=[4 -3 1];Q=[6 -4 7];R=[1 2 2];    % 점 P, Q, R 입력
X=[x y z];PQ=Q-P;PR=R-P;
n=cross(PQ,PR)                      % 법선벡터 계산
dot(n,X-P)