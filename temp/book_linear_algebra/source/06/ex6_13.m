format rat                                      % 분수 형태로 출력
A=[6 -3;-1 1];                                  % 변환행렬 입력
Ainv=inv(A);                                    % 역행렬 계산
x1=[-18;5];x2=[15;-2];x3=[-6;4];                % 벡터 입력
InvLx1=Ainv*x1,InvLx2=Ainv*x2,InvLx3=Ainv*x3    % 역변환 계산