syms c1 c2 c3 c4                                % 심볼릭 변수 지정
Lx1=[1 0 0 1];Lx2=[0 1 0 1];Lx3=[1 0 1 0];Lx4=[0 1 1 1]; 
y1=[1 0 0 1];y2=[0 0 1 1];y3=[1 1 0 0];y4=[0 1 1 1];

Lx1S=solve(Lx1==c1*y1+c2*y2+c3*y3+c4*y4); 
Lx1s=[Lx1S.c1 Lx1S.c2 Lx1S.c3 Lx1S.c4]; 

Lx2S=solve(Lx2==c1*y1+c2*y2+c3*y3+c4*y4);
Lx2s=[Lx2S.c1 Lx2S.c2 Lx2S.c3 Lx2S.c4];

Lx3S=solve(Lx3==c1*y1+c2*y2+c3*y3+c4*y4);
Lx3s=[Lx3S.c1 Lx3S.c2 Lx3S.c3 Lx3S.c4];

Lx4S=solve(Lx4==c1*y1+c2*y2+c3*y3+c4*y4);
Lx4s=[Lx4S.c1 Lx4S.c2 Lx4S.c3 Lx4S.c4];

LS=[Lx1s' Lx2s' Lx3s' Lx4s']                            % 변환행렬 계산