u=[-2 3 4];v=[5 -3 2];                      % ���⺤�� �Է�
theta=acos(abs(dot(u,v))/(norm(u)*norm(v))) % �� ���� ������ �� ���
degree=theta/pi*180                         % ���� ���� 60�й����� ��ȯ
u=[3 -2 1];v=[-3 -4 1];
theta=acos(abs(dot(u,v))/(norm(u)*norm(v)))
degree=theta/pi*180