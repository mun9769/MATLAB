syms x(t) y(t)                                              % �ɺ��� ���� ����
u=dsolve(diff(x)==7*x-10*y,diff(y)==3*x-4*y,x(0)==1,y(0)==0);    % �����̺й����� ���
sol=[u.x u.y]                                               % Ư���� ���