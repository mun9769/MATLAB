format rat
x1=[1 0 0]';x2=[1 1 0]';x3=[1 1 1]';                % ���� �Է�
y1=1/norm(x1)*x1                                    % 1�ܰ� ���
z2=x2-dot(x2,y1)*y1;y2=1/norm(z2)*z2                % 2�ܰ� ���
z3=x3-dot(x3,y1)*y1-dot(x3,y2)*y2;y3=1/norm(z3)*z3  % 3�ܰ� ���