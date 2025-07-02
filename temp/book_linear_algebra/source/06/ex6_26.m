syms c1 c2 c3                           % 심볼릭 변수 지정
Lx=solve(c1==1,c2+c3==0,c1-c2+c3==0); 
Lx=[Lx.c1 Lx.c2 Lx.c3];
Ly=solve(c1==0,c2+c3==1,c1-c2+c3==0); 
Ly=[Ly.c1 Ly.c2 Ly.c3];
Lst=[Lx' Ly']