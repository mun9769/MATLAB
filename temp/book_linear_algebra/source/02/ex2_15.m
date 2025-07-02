n=sym('n');                 % 심볼릭 변수 n 지정
An=[1+6*n 4*n;-9*n 1-6*n];  % 행렬 A^n 입력
syms x0 y0                  % 심볼릭 변수 x0, y0 지정
X0=[x0;y0];
An*X0 