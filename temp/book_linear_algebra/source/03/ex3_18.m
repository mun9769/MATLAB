format rat                      % 출력 형태 지정
A=[1 2 3;2 3 3;3 -1 2];         % 행렬 A, B 입력
B=[1 2 3 1;2 3 3 1;3 -1 2 1;1 1 1 1];
Ainv=inv(A);Binv=inv(B);        % A, B의 역행렬 계산
detAinv=det(Ainv),detA=det(A)   % 행렬식 계산
detBinv=det(Binv),detB=det(B) 