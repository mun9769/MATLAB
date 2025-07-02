syms x y            % 심볼릭 변수 x, y 지정
ezplot('x+y=4'); 1  % [예제 1-4(a)]의 연립일차방정식 그리기
hold on 
ezplot('-x+2*y=8')
hold off 
ezplot('2*x-y=-4'); % [예제 1-4(b)]의 연립일차방정식 그리기
hold on
ezplot('-2*x+y=6')
hold off
ezplot('-x+2*y=6'); % [예제 1-4(c)]의 연립일차방정식 그리기
hold on
ezplot('2*x-4*y=-12')