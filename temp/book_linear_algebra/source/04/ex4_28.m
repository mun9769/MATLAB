syms x y z                      % �ɺ��� ���� ����
t=sym('t');
x=-2*t+1;y=-t+3;z=2*t-2;        % x, y, z�� t�� ���Ͽ� ���
solve(x-2*y+z-3==0,t)           % t ���