u=[1+1i 0 2-1i];v=[2 3i 1i];   % ���� �Է�
uv=u*v',Nu=norm(u),Nv=norm(v),Nuv=norm(u+v) 
NuNv=norm(u)+norm(v) 
syms c d
S=solve(c*u+d*v==0);        % �������� Ȯ��
Sol=[S.c S.d]