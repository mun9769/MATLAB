format rat
x=[-2 -3 1];y=[2 -1 4];     % ���� �Է�
u=1/norm(y)*y;              % ������ ����ȭ
projx=dot(x,u)*u            % ���翵 ���
v2=x-projx                  % y�� ������ x�� ���ͼ��� ���