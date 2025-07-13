clear; close all;
T = 0.2;
dt=1e-4;
fs=1/dt;
t = 0: dt : T;

f = 1/T;
theta = 2*pi*f*t;
n = numel(theta);

ma = 1.2; % ~1까지 선형변조, ~약 3.24 과변조
ma = 0.8; 
mf = 9;

v_ref = ma* sin(2*pi*f*t); % f=1/T, 주기는 T
v_c = sawtooth(2*pi*(mf*f)*t,1/2);

S_HB = -ones(1,length(t));
S_HB(v_ref > v_c) = 1;

% model fit : X = A*cos(order*theta) + B*sin(order*theta) + C
C = mean(S_HB);
y = S_HB-C;
order = 1:20*mf;
nth_mag = zeros(3,length(order)); % [cos; sin; sqrt(cos^2+sin^2);]

for o=order(end:-1:1)
    A = 2/n*trapz(y.*cos(o*theta));
    B = 2/n*trapz(y.*sin(o*theta));
    yfit = A*cos(o*theta) + B*sin(o*theta) + C;
    nth_mag(1,o) = A;
    nth_mag(2,o) = B;
    nth_mag(3,o) = norm([A B]);
end

recover_sum = zeros(1,length(theta));
for o=order
    recover_sum = recover_sum + nth_mag(1,o) * cos(o*theta);
    recover_sum = recover_sum + nth_mag(2,o) * sin(o*theta);
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% view %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure; 
subplot 211, hold on;
plot(theta, v_ref, linestyle='none', marker='.')
plot(theta, v_c)
axis([0 theta(end) -ma*1.2 ma*1.2])
title('carrier and v_{ref}')

subplot 212
plot(theta, S_HB)
axis([0 theta(end) -1.2 1.2])
title('S_{HB}')
grid on

figure
plot(theta, y, 'b',theta, yfit, 'r')
text(theta(round(n/4)), B, num2str(B))
axis([0 theta(end) -1.2 1.2])
grid on;
legend('S_{HB}','foundamental wave');

figure
stem(order, nth_mag(3,:))
title('harmonics'), xlabel('n_{th}'), ylabel('magnitude');

figure; hold on;
plot(theta, S_HB)
plot(theta, recover_sum) 
legend
grid on

% todo: 고조파 성분 THD (page379)
% todo: 6-step 출력전압제어 (page427) -> 이거 하면 거의 끝



