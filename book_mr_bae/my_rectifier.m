function my_rectifier(fo, Tau, type)
% [정류기]
% <입력 변수>
%       fo: 교류 주파수[Hz]
%       Tau: 정류기 시정수[sec]
%       type: 'h': 반파정류
%             'f': 전파정류

dt=1/(100*fo); % 시간 간격
T=4/fo; % 4개의 주기
t=0:dt:T;
D=exp(-dt/Tau); % 시정수에 의한 방전률

ac_sig = sin(2*pi*fo*t);
if type=='f' ac_sig = abs(ac_sig); end

rect_sig = zeros(1,length(ac_sig));
for n=2:length(ac_sig)
    env=rect_sig(n-1)*D;
    a = ac_sig(n) >= env;
    b = ac_sig(n) <  env;
    rect_sig(n)= a * ac_sig(n) + b * env;
end

clf
line([0 T],[0 0])
hold on
plot(t,ac_sig,'b');
plot(t,rect_sig,'r');
axis([0 T, -1.2 1.2]);
title('rectifier'), xlabel("time(s)"), ylabel('voltage');



