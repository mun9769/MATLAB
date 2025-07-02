a=[-2 0 1];x1=[-1/sqrt(2) 1/sqrt(2) 0];x2=[1/sqrt(3) 1/sqrt(3) 1/sqrt(3)];     % 벡터 입력
proja=dot(a,x1)*x1+dot(a,x2)*x2         % 정사영 계산
w=a-proja                               % W에 대한 a의 직교성분