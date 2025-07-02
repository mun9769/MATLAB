format rat
A=[3 2 -1;1 6 3;2 -4 0] % 행렬 입력
B=adj(A)                % A의 수반행렬 계산
C=1/det(A)*B            % 수반행렬을 이용한 역행렬 계산
Ainv=inv(A)             % 명령어를 이용한 역행렬 계산