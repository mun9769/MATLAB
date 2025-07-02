A=[1 1 1;1 2 2;1 2 3];  % 행렬 A 입력
I3=eye(3);              % 3차 단위행렬 입력
rref([A,I3])            % [A|I3]의 RREF 계산
Ainv=inv(A)             % 역행렬 계산