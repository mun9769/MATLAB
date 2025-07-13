% 모터 파라미터
P = 24;
Lds = 30e-3;
Lqs = 40e-3;
Lamf = 0.12; % [Wb]
Vsmax = 400;
Ismax = 10; % Arms

% 전압 제한 방정식 (w_eqn)
w_eqn = @(ids, iqs, w) (Vsmax/w)^2 - ((Lamf + Lds*ids)^2 + (Lqs*iqs)^2);

% 토크 방정식 (Te_eqn: Te = 10 Nm으로 고정)
Te_eqn = @(ids, iqs) 10 - (3/2*P * (ids*iqs*(Lds - Lqs) + Lamf*iqs));

% 접점 탐색을 위한 함수 정의
fun = @(x) [
    Te_eqn(x(1), x(2));           % Te_eqn(ids, iqs) = 0
    w_eqn(x(1), x(2), x(3));      % w_eqn(ids, iqs, w) = 0
    % 기울기 평행 조건 (∇Te_eqn ∝ ∇w_eqn)
    (3/2*P * (x(2)*(Lds - Lqs))) / (-2*Lds*(Lamf + Lds*x(1))) - ...
    (3/2*P * (x(1)*(Lds - Lqs) + Lamf)) / (-2*Lqs^2*x(2))
];

% 초기 추정값 (ids, iqs, w)
x0 = [0, Ismax/sqrt(2), 1000]; % 예시: iqs ≈ Ismax/√2, w = 1000 rad/s

% 비선형 연립방정식 풀기
options = optimoptions('fsolve', 'Display', 'iter', 'Algorithm', 'levenberg-marquardt');
x_sol = fsolve(fun, x0, options);

% 결과 출력
ids_sol = x_sol(1);
iqs_sol = x_sol(2);
w_sol = x_sol(3);

fprintf('접점: ids = %.4f A, iqs = %.4f A\n', ids_sol, iqs_sol);
fprintf('각속도 w = %.4f rad/s (≈ %.2f RPM)\n', w_sol, w_sol * 60/(2*pi));

% 검증: 접점에서의 함수 값 확인
te_val = Te_eqn(ids_sol, iqs_sol);
w_val = w_eqn(ids_sol, iqs_sol, w_sol);
fprintf('Te_eqn(ids, iqs) = %.4f (오차: %.2e)\n', te_val, abs(te_val));
fprintf('w_eqn(ids, iqs, w) = %.4f (오차: %.2e)\n', w_val, abs(w_val));

% 시각화 (ids, iqs 평면)
figure;
fimplicit(@(ids, iqs) Te_eqn(ids, iqs), [-Ismax, Ismax, -Ismax, Ismax], 'r'); hold on;
fimplicit(@(ids, iqs) w_eqn(ids, iqs, w_sol), [-Ismax, Ismax, -Ismax, Ismax], 'b');
plot(ids_sol, iqs_sol, 'ko', 'MarkerSize', 10);
xlabel('i_{ds} [A]'); ylabel('i_{qs} [A]');
legend('Te = 10 Nm', 'Voltage Limit', '접점');
grid on;