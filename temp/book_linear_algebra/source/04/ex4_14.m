x=[3 -1 1];y=[-1 4 -2];z=[2 2 -1];      % 벡터 입력
LHS=cross(x,cross(y,z))                 % 주어진 식의 좌변 입력
RHS=dot(x,z)*y-dot(x,y)*z               % 주어진 식의 우변 입력