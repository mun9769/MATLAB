format rat
A=1/sqrt(3)*[1+1i 1;-1 1-1i];             % ��� A �Է�
A'*A                                    % ����������� Ȯ��
Lambda=eig(A);                          % ������ ���
L1=norm(Lambda(1)),L2=norm(Lambda(2))   % �������� ���� ���