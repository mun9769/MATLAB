format rat
A=[1 2 1;3 -1 -1;1 1 -2];                     % ��� �Է�
B=[12 -1 -3]';                                    % ����� ���� �Է�
M1=A;
M1(:,1)=B 
M2=A;
M2(:,2)=B 
M3=A;
M3(:,3)=B 
x=det(M1)/det(A),y=det(M2)/det(A),z=det(M3)/det(A) % x ,y, z ���