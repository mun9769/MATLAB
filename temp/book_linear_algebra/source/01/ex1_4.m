syms x y            % �ɺ��� ���� x, y ����
ezplot('x+y=4'); 1  % [���� 1-4(a)]�� �������������� �׸���
hold on 
ezplot('-x+2*y=8')
hold off 
ezplot('2*x-y=-4'); % [���� 1-4(b)]�� �������������� �׸���
hold on
ezplot('-2*x+y=6')
hold off
ezplot('-x+2*y=6'); % [���� 1-4(c)]�� �������������� �׸���
hold on
ezplot('2*x-4*y=-12')