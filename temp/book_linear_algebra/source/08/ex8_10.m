coeff=[1 0 0 8];                    % 방정식의 계수 입력
zroots=roots(coeff);                % 방정식 근 계산
plot(real(zroots),imag(zroots),'*') % 복소수 근을 그래프로 그리기
grid on                             % 격자 추가
xlabel('real z');ylabel('imag z');  % 축 이름 지정
title('3rd root of ?8')             % 그래프 제목 지정
axis([-3 3 -3 3])                   % 축 범위 지정