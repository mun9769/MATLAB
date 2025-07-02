syms x(t) y(t) z(t)                                                        % 심볼릭 변수 지정
w=dsolve(diff(x)== 5*x,diff(y)==-y,diff(z)==4*z);                          % 연립미분방정식 계산
sol=[w.x w.y w.z]                                                          % 연립미분방정식의 일반해
w=dsolve(diff(x)==5*x,diff(y)==-y, diff(z)==4*z,x(0)==2,y(0)==-4,z(0)==3); % 연립미분방정식과 초기치 계산
sol=[w.x w.y w.z]                                                          % 연립미분방정식의 특수해