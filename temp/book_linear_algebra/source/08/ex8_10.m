coeff=[1 0 0 8];                    % �������� ��� �Է�
zroots=roots(coeff);                % ������ �� ���
plot(real(zroots),imag(zroots),'*') % ���Ҽ� ���� �׷����� �׸���
grid on                             % ���� �߰�
xlabel('real z');ylabel('imag z');  % �� �̸� ����
title('3rd root of ?8')             % �׷��� ���� ����
axis([-3 3 -3 3])                   % �� ���� ����