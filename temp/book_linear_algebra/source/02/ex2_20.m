A=[2 1;5 3];B=[6 -2;4 -1];      % 행렬 A, B 입력
InvA=inv(A);InvB=inv(B);        % 행렬 A, B의 역행렬 계산
AB=A*B;                         % AB 계산
format rat                      % 분수형태 지정
L=inv(AB)                       % 주어진 식의 좌변 계산
R=InvB*InvA                     % 주어진 식의 우변 계산