format
P=[-1 2 1];Q=[0 2 2];R=[2 3 0];       % �� P, Q, R �Է�
QR=R-Q;QP=P-Q;                        % ���� ����
d=1/norm(QR)*norm(cross(QR,QP))     % ������ �̸��� �Ÿ� ���
