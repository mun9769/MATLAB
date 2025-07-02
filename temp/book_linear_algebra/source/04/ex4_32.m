format
P=[-1 2 1];Q=[0 2 2];R=[2 3 0];       % 점 P, Q, R 입력
QR=R-Q;QP=P-Q;                        % 벡터 생성
d=1/norm(QR)*norm(cross(QR,QP))     % 직선에 이르는 거리 계산
