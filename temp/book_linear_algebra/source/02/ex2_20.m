A=[2 1;5 3];B=[6 -2;4 -1];      % ��� A, B �Է�
InvA=inv(A);InvB=inv(B);        % ��� A, B�� ����� ���
AB=A*B;                         % AB ���
format rat                      % �м����� ����
L=inv(AB)                       % �־��� ���� �º� ���
R=InvB*InvA                     % �־��� ���� �캯 ���