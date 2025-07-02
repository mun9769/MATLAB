syms x y z                      % 심볼릭 변수 지정
t=sym('t');
x=-2*t+1;y=-t+3;z=2*t-2;        % x, y, z를 t에 대하여 계산
solve(x-2*y+z-3==0,t)           % t 계산