syms x y                             % 심볼릭 변수 x, y 지정
S=solve(3*x+2*y==12, 3*x-2*y==-4);   % 연립일차방정식 계산
S=[S.x S.y]