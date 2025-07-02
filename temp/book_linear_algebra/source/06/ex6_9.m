x=[1;2]                                         % 벡터 x 입력
R=[ cos(pi/6) -sin(pi/6);sin(pi/6) cos(pi/6)];  % 변환행렬 입력
Lx=R*x                                          % L(x) 계산
vectarrow([0;0],x)                              % 벡터 x 그리기
hold on                                         % 그림 유지
vectarrow([0;0],Lx)                             % 벡터 L(x) 그리기