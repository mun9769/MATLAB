a=[-2 0 1];x1=[-1/sqrt(2) 1/sqrt(2) 0];x2=[1/sqrt(3) 1/sqrt(3) 1/sqrt(3)];     % ���� �Է�
proja=dot(a,x1)*x1+dot(a,x2)*x2         % ���翵 ���
w=a-proja                               % W�� ���� a�� ��������