format rat                  % 출력 형태 지정
A=[1 6 4;6 12 -3;-2 4 10];  % 행렬 A 입력
I3=eye(3);                  % 단위행렬 지정
rref([A,I3])                % 행렬 [A|I3]의 RREF 계산
Ainv=inv(A)                 % 역행렬 계산