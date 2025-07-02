z1=sqrt(3)+1i                % [예제 8-5(a)]의 복소수 입력
r=abs(z1),theta=angle(z1)   % 절댓값과 편각 계산
theta1=theta*180/pi         % 각도를 60분법으로 변환
z1=r*exp(1i*theta)           % 극형식 확인
z2=-1-1i                     % [예제 8-5(b)]의 복소수 입력
r=abs(z2),theta=angle(z2)
theta2=theta*180/pi
z2=r*exp(1i*theta)