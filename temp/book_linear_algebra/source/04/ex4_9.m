a=[9 -2];b=[4 18];                          % [���� 4-9(a)]�� ���� �Է�
theta=acos(dot(a,b)/(norm(a)*norm(b)))      % �� ���� ������ �� ���
degree=theta/pi*180                         % ���� ���� 60�й����� ��ȯ
u=[-1 2 2];v=[-1 1 0];                      % [���� 4-9(b)]�� ���� �Է�
theta=acos(dot(u,v)/(norm(u)*norm(v)))
degree=theta/pi*180
x=[-2 1 3];y=[2 -1 -3];                     % [���� 4-9(c)]�� ���� �Է�
theta=acos(dot(x,y)/(norm(x)*norm(y)))
degree=theta/pi*180
x=[-1 2 -3];y=[2 1 -2];                     % [���� 4-9(d)]�� ���� �Է�
theta=acos(dot(x,y)/(norm(x)*norm(y)))
degree=theta/pi*180