format rat
A=1/sqrt(3)*[1+1i 1;-1 1-1i];             % 행렬 A 입력
A'*A                                    % 직교행렬인지 확인
Lambda=eig(A);                          % 고유값 계산
L1=norm(Lambda(1)),L2=norm(Lambda(2))   % 고유값의 절댓값 계산