u=[-2 3 4];v=[5 -3 2];                      % 방향벡터 입력
theta=acos(abs(dot(u,v))/(norm(u)*norm(v))) % 두 벡터 사이의 각 계산
degree=theta/pi*180                         % 라디안 값을 60분법으로 변환
u=[3 -2 1];v=[-3 -4 1];
theta=acos(abs(dot(u,v))/(norm(u)*norm(v)))
degree=theta/pi*180