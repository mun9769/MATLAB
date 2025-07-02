A=[1 2 3 0;1 0 1 0;3 4 7 0];    % 계수행렬 A 입력
B=rref(A)                       % A의 RREF 계산
s=sym('s');                     % 심볼릭 변수 s 지정
z=s;                            % z=s로 임의의 실수 지정
x=-z;y=-z;                      % 변수 x, y의 z에 대한 풀이
sol=[x y z] 