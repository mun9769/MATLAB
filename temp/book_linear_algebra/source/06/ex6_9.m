x=[1;2]                                         % ���� x �Է�
R=[ cos(pi/6) -sin(pi/6);sin(pi/6) cos(pi/6)];  % ��ȯ��� �Է�
Lx=R*x                                          % L(x) ���
vectarrow([0;0],x)                              % ���� x �׸���
hold on                                         % �׸� ����
vectarrow([0;0],Lx)                             % ���� L(x) �׸���