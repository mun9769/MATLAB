clear; close all;
syms Vsmax
syms Lqs Lds Lamf 
syms iqs ids w;
syms Te;
syms P;
% assume(ids < 0);

% fve40 example parameter
P = 24;
Lds = 30e-3;
Lqs = 40e-3;
Lamf = 0.12; % [Wb]
Vsmax = 400;
Ismax = 10; % Arms
% wrpm_rated = 400; % rpm
eDiff = @(eqn) rhs(eqn) - lhs(eqn);

w_eqn = (Vsmax/w)^2 == (Lamf+Lds*ids)^2 + (Lqs*iqs)^2; % 우변이 lambda의 크기이다.??
Te_eqn = Te == (ids*iqs*(Lds - Lqs) + Lamf*iqs)*3/2*P; 

% lambda = rhs(w_eqn);
% % 여기서 일정토크라고 가정하면 iqs는 ids에 대해서 표현할 수 있다.
% iqs_ans = solve(Te_eqn, iqs);
% kk = subs(lambda, iqs, iqs_ans) % 3/2*P를 빼면 배박논(5-7)식과 동일함.
% my_latex(kk)

w_solution = solve(w_eqn, w);
w_solution = w_solution(2); % 임시방편.

MTPV_position=[];
MTPA_position=[];
wrm_list=[];
Pout=[];

if exist('data.mat', 'file')
    load('data.mat');
    % save('data.mat', 'MTPA_position', '-append');
    % save('data.mat', 'MTPV_position', '-append')
else
    % MTPA 계산
    for te=1:40
        eqn = subs(Te_eqn, Te, te);
        [x_mn, y_mn, dist] = my_Lagrange_multiplier(eDiff(eqn), ids, iqs);
        MTPA_position(te,:) = [x_mn y_mn];
        
        wrm = subs(w_solution, [ids iqs], [x_mn y_mn]);
        wrm = wrm(wrm>0);
        wrm = double(wrm) / (P/2);

        Pout(end+1) = wrm * te;
        wrm_list(end+1) = wrm;
    end

    % MTPV 계산
    for te=1:40
        t_eqn = subs(Te_eqn, Te, te);
        [x_mn, y_mn] = my_Lagrange_multiplier2(w_solution, eDiff(t_eqn), ids, iqs);
        MTPV_position(te,:) = [x_mn y_mn];
    end
end



% 전압 제한원
wrpm_val = [1000 1200 1400 1600 1800];
wr_val = wrpm_val*(2*pi/60) * (P/2);  
w_eqn1=subs(w_eqn, w, wr_val(3));
w_eqn2=subs(w_eqn, w, wr_val(4));
w_eqn3=subs(w_eqn, w, wr_val(5));

% 전류 제한원
Te_eqn1 = subs(Te_eqn, Te, 10);
Te_eqn2 = subs(Te_eqn, Te, 20);
Te_eqn3 = subs(Te_eqn, Te, 30);
Te_eqn4 = subs(Te_eqn, Te, 40);

% Lagrange 승수법을 사용해서 곡선과 원점 사이의 최단거리를 구한다.
[~, ~, dist_1] = my_Lagrange_multiplier(eDiff(Te_eqn1), ids, iqs);
[~, ~, dist_2] = my_Lagrange_multiplier(eDiff(Te_eqn2), ids, iqs);
[~, ~, dist_3] = my_Lagrange_multiplier(eDiff(Te_eqn3), ids, iqs);
[ids_mn, iqs_mn, dist_4] = my_Lagrange_multiplier(eDiff(Te_eqn4), ids, iqs);
circle_eqn1 = @(ids, iqs) ids^2+iqs^2 - dist_4^2;

% 전류제한원에서 MTPA인 점 찾기.
p_opt = fmincon(@(p) norm(p - [ids_mn iqs_mn]), ...
    [0 0], [], [], [], [], [-100 0], [0 100], ...
    @(p) deal([], circle_eqn1(p(1), p(2))), ...
    optimoptions('fmincon', 'display', 'off'))


% 전압제한원과 전류제한원의 교점 구하기.
[sol_ids, sol_iqs] = solve([w_eqn3 circle_eqn1], [ids iqs]);
sol_ids = double(sol_ids(1));
sol_iqs = double(sol_iqs(1));
a = [sol_ids sol_iqs];
b = [ids_mn iqs_mn];

% MFPT를 구해보자
lambda = rhs(w_eqn)
lambda = sqrt(lambda);
% 여기서 일정토크라고 가정하면 iqs는 ids에 대해서 표현할 수 있다.
iqs_ans = solve(Te_eqn, iqs);

lambda = subs(lambda, iqs, iqs_ans); % 3/2*P를 빼면 배박논(5-7)식과 동일함.
lambda_Te40 = subs(lambda, Te, 40);
lambda_Te30 = subs(lambda, Te, 30);
lambda_Te20 = subs(lambda, Te, 20);
lambda_Te10 = subs(lambda, Te, 10);

ids_ = linspace(-10, 0, 200);
lambda_Te10_val = double(subs(lambda_Te10, ids, ids_));
lambda_Te20_val = double(subs(lambda_Te20, ids, ids_));
lambda_Te30_val = double(subs(lambda_Te30, ids, ids_));
lambda_Te40_val = double(subs(lambda_Te40, ids, ids_));

[~, idx_Te10] = min(lambda_Te10_val);
[~, idx_Te20] = min(lambda_Te20_val);
[~, idx_Te30] = min(lambda_Te30_val);
[~, idx_Te40] = min(lambda_Te40_val);

iqs_Te10 = subs(iqs_ans, [ids Te], [ids_(idx_Te10) 10]);
iqs_Te20 = subs(iqs_ans, [ids Te], [ids_(idx_Te20) 20]);
iqs_Te30 = subs(iqs_ans, [ids Te], [ids_(idx_Te30) 30]);
iqs_Te40 = subs(iqs_ans, [ids Te], [ids_(idx_Te40) 40]);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% view %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure; hold on;
set(gcf, 'Name', '토크 별 동작점의 이동에 따른 자속의 크기', 'NumberTitle', 'off');
plot(ids_, lambda_Te40_val, 'displayname', 'Te=40Nm');
plot(ids_, lambda_Te30_val, 'displayname', 'Te=30Nm');
plot(ids_, lambda_Te20_val, 'displayname', 'Te=20Nm');
plot(ids_, lambda_Te10_val, 'displayname', 'Te=10Nm');

plot(ids_(idx_Te10), lambda_Te10_val(idx_Te10), 'ro')
plot(ids_(idx_Te20), lambda_Te20_val(idx_Te20), 'ro')
plot(ids_(idx_Te30), lambda_Te30_val(idx_Te30), 'ro')
plot(ids_(idx_Te40), lambda_Te40_val(idx_Te40), 'ro')
legend();

%%


figure; hold on;


plot(ids_(idx_Te10), iqs_Te10, 'ro', 'linewidth', 3)
plot(ids_(idx_Te20), iqs_Te20, 'ro', 'linewidth', 3)
plot(ids_(idx_Te30), iqs_Te30, 'ro', 'linewidth', 3)
plot(ids_(idx_Te40), iqs_Te40, 'ro', 'linewidth', 3)


title("전압제한타원과 전류제한원");
set(gcf, 'Name', 'Voltage and Current limit Analysis', 'NumberTitle', 'off');
plot(MTPV_position(:,1), MTPV_position(:,2), 'k.')
plot(sol_ids, sol_iqs, 'ro');
f1=fimplicit(w_eqn1, 'k--');
f2=fimplicit(w_eqn2, 'k--');
f3=fimplicit(w_eqn3, 'k--');
f4=plot(-Lamf/Lds, 0, 'ro', displayname='전압제한타원 원점');
drawnow;

text(f1.XData(1), f1.YData(1),'w_{1}', 'backgroundColor', 'white', fontsize=12);
text(f2.XData(1), f2.YData(1),'w_{2}', 'backgroundColor', 'white', fontsize=12);
text(f3.XData(1), f3.YData(1),'w_{3}', 'backgroundColor', 'white', 'fontsize', 12);


xlabel('d-axis'); ylabel('q-axis')
axis([-Ismax 2 -6 6]*1.5)
pbaspect([1 1 1])
plot([0 0], [-Ismax Ismax] *1.5, 'k', 'LineWidth', 0.5);
plot([-Ismax Ismax]*1.5, [0 0], 'k', 'LineWidth', 0.2);


% figure; hold on;
f1te=fimplicit(Te_eqn1, 'color', 'k');
f2te=fimplicit(Te_eqn2, color='k');
f3te=fimplicit(Te_eqn3, color='k');
f4te=fimplicit(Te_eqn4, color='k');

f2di=fimplicit(ids^2+iqs^2==dist_2^2, color='k');
f3di=fimplicit(ids^2+iqs^2==dist_3^2, color='k');
f4di=fimplicit(ids^2+iqs^2==dist_4^2, color='k');


f1MTPA=plot(MTPA_position(:,1), MTPA_position(:,2), linewidth=2, color='b');
drawnow;

text(f1te.XData(end-3), f1te.YData(end-3),'Te=10Nm', 'backgroundColor', 'white', fontsize=12);
text(f2te.XData(end-6), f2te.YData(end-6),'Te=20Nm', 'backgroundColor', 'white', fontsize=12);
text(f3te.XData(end-9), f3te.YData(end-9),'Te=30Nm', 'backgroundColor', 'white', fontsize=12);
text(f4te.XData(end-15),f4te.YData(end-15),'Te=40Nm', 'backgroundColor', 'white', fontsize=12);
text(MTPA_position(end,1), MTPA_position(end,2), 'MTPA: ~40Nm', ...
    backgroundcolor='white', ...
    fontsize=12, color='b');

xlabel('d-axis'); ylabel('q-axis')
axis([-Ismax 2 -6 6]*1.5)
pbaspect([1 1 1])
plot([0 0], [-Ismax Ismax] *1.5, 'k', 'LineWidth', 0.5);
plot([-Ismax Ismax]*1.5, [0 0], 'k', 'LineWidth', 0.2); 



% Plot the results for MTPA and MTPV positions
plot(MTPV_position(:,1), MTPV_position(:,2), 'go', 'DisplayName', 'MTPV Points');

param_str = sprintf(...
    'Lds = %.2f mH, Lqs = %.2f mH\nLamf = %.2f Wb, P = %d, Vsmax = %.0f V', ...
    Lds*1e3, Lqs*1e3, Lamf, P, Vsmax);

text(-14, -8, param_str, ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'middle', ...
    'FontSize', 10, ...
    'Interpreter', 'none');


% figure; % 그닥 중요하지 않은듯?
% title("MTPA power Analysis");
% plot(wrm_list, Pout, 'k.');
% xlabel("w_{rm} [rad/s]"), ylabel("P_{out} [W]")
% set(gcf, 'Name', 'MTPA power Analysis', 'NumberTitle', 'off'); 

