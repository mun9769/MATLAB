syms x(t) y(t) z(t)                                                        % �ɺ��� ���� ����
w=dsolve(diff(x)== 5*x,diff(y)==-y,diff(z)==4*z);                          % �����̺й����� ���
sol=[w.x w.y w.z]                                                          % �����̺й������� �Ϲ���
w=dsolve(diff(x)==5*x,diff(y)==-y, diff(z)==4*z,x(0)==2,y(0)==-4,z(0)==3); % �����̺й����İ� �ʱ�ġ ���
sol=[w.x w.y w.z]                                                          % �����̺й������� Ư����