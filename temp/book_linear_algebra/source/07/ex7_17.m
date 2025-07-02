syms x(t) y(t)                                              % 심볼릭 변수 지정
u=dsolve(diff(x)==7*x-10*y,diff(y)==3*x-4*y,x(0)==1,y(0)==0);    % 연립미분방정식 계산
sol=[u.x u.y]                                               % 특수해 계산