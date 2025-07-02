a=[9 -2];b=[4 18];                          % [예제 4-9(a)]의 벡터 입력
theta=acos(dot(a,b)/(norm(a)*norm(b)))      % 두 벡터 사이의 각 계산
degree=theta/pi*180                         % 라디안 값을 60분법으로 변환
u=[-1 2 2];v=[-1 1 0];                      % [예제 4-9(b)]의 벡터 입력
theta=acos(dot(u,v)/(norm(u)*norm(v)))
degree=theta/pi*180
x=[-2 1 3];y=[2 -1 -3];                     % [예제 4-9(c)]의 벡터 입력
theta=acos(dot(x,y)/(norm(x)*norm(y)))
degree=theta/pi*180
x=[-1 2 -3];y=[2 1 -2];                     % [예제 4-9(d)]의 벡터 입력
theta=acos(dot(x,y)/(norm(x)*norm(y)))
degree=theta/pi*180