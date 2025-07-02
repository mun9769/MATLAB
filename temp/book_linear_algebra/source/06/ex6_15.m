format rat
syms c1 c2 c3;                                   % �ɺ��� ���� ����
u1=[1 1 1];u2=[-1 0 1];u3=[0 1 -1];v=[3 0 -2];   % ���� �Է�
sol=solve(v==c1*u1+c2*u2+c3*u3);                 % v ���
S=[sol.c1 sol.c2 sol.c3] 
Lu1=[2 -3];Lu2=[-2 3];Lu3=[-1 2];
Lv=1/3*Lu1-8/3*Lu2-1/3*Lu3                       % L(v) ���