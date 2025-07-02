u=[1+1i 0 2-1i];v=[2 3i 1i];   % 벡터 입력
uv=u*v',Nu=norm(u),Nv=norm(v),Nuv=norm(u+v) 
NuNv=norm(u)+norm(v) 
syms c d
S=solve(c*u+d*v==0);        % 일차독립 확인
Sol=[S.c S.d]