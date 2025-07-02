x=[-2 1 -1 0 1];y=[-1 2 1 3 1];             % 벡터 입력
theta=acos(dot(x,y)/(norm(x)*norm(y)))      % 두 벡터 사이의 각 계산
degree=theta/pi*180                         % 라디안을 60분법으로 변환