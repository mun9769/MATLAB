function a = my_sound()

% 1. 기본 파라미터 설정
Fs = 44100;      % 샘플링 레이트 (Hz). CD 음질과 동일. 보통 44100이나 48000을 많이 사용.
duration = 10;    % 소리 지속 시간 (초)
frequency = 440; % 주파수 (Hz). 440Hz는 '라(A4)' 음에 해당.

% 2. 시간 벡터 생성
% 0초부터 duration초까지 Fs 간격으로 시간을 나눔
t = 0:1/Fs:duration-1/Fs; 

% 3. 사인파 신호 생성
% y = sin(2 * pi * 주파수 * 시간)
y = sin(2 * pi * frequency * t);

% 4. 소리 재생
% sound(신호, 샘플링레이트)
sound(y, Fs);

end