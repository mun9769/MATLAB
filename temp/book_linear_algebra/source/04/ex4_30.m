n1=[3 -7 0];n2=[-5 -2 3];                       % 벡터 입력
theta=acos(abs(dot(n1,n2))/(norm(n1)*norm(n2))) % 두 벡터 사이의 각 계산
degree=theta/pi*180                             % 라디안을 60분법으로 변환
n1=[-2 3 -4];n2=[4 -6 8];
theta=acos(abs(dot(n1,n2))/(norm(n1)*norm(n2)))
degree=theta/pi*180