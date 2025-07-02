x=[2 3 0 -1 -2 1];y=[-1 0 1 -1 0 1];    % 벡터 입력
dp=dot(x,y)                             % 내적 계산
L=norm(x+y)^2                       
R=norm(x)^2+norm(y)^2 