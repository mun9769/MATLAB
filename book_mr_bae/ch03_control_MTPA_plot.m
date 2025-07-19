clear; close all;
syms Vsmax
syms Lqs Lds Lamf 
syms iqs ids w;
syms Te;
syms P;

% fve40 example parameter
P = 24;
Lds = 30e-3;
Lqs = 40e-3;
Lamf = 0.12; % [Wb]
Vsmax = 60;
Ismax = 8; % Arms
eDiff = @(eqn) rhs(eqn) - lhs(eqn);

w_eqn = (Vsmax/w)^2 == (Lamf+Lds*ids)^2 + (Lqs*iqs)^2; % 우변이 lambda의 크기이다.??
Te_eqn = Te == (ids*iqs*(Lds - Lqs) + Lamf*iqs)*3/2*P; 

% lambda = rhs(w_eqn);
% iqs_ans = solve(Te_eqn, iqs);
% kk = subs(lambda, iqs, iqs_ans) % 3/2*P를 빼면 배박논(5-7)식과 동일함.
% my_latex(kk)

w_solution = solve(w_eqn, w);
w_solution = w_solution(2); % 임시방편.

MFPT_position=[];
MTPA_position=[];
wrm_list=[];
Pout=[];

if exist('data.mat', 'file')
    load('data.mat');
    % save('data.mat', 'MTPA_position', '-append');
    % save('data.mat', 'MFPT_position', '-append')
else
    % MTPA 계산
    for te=1:40
        eqn = subs(Te_eqn, Te, te);
        [x_mn, y_mn, dist] = my_Lagrange_multiplier(eDiff(eqn), ids, iqs);
        MTPA_position(te,:) = [x_mn y_mn];
    end

    % MFPT 계산
    for te=1:32 % 전류제한원과 닿는 지점은 Te=32Nm이다
        t_eqn = subs(Te_eqn, Te, te);
        [x_mn, y_mn] = my_Lagrange_multiplier2(w_solution, eDiff(t_eqn), ids, iqs);
        MFPT_position(te,:) = [x_mn y_mn];
    end
end

to_rps = 2*pi/60;
to_rpm = 60/2/pi;

wrpm_val = 100:1:300;
wr_val = wrpm_val * to_rps * (P/2);


% 전류 제한원
eqn_Te10 = subs(Te_eqn, Te, 10);
eqn_Te20 = subs(Te_eqn, Te, 20);
eqn_Te30 = subs(Te_eqn, Te, 30);
eqn_Te40 = subs(Te_eqn, Te, 40);
xy_Te10 = my_eqn_to_xy(eqn_Te10, [0 -10]);
xy_Te20 = my_eqn_to_xy(eqn_Te20, [0 -10]);
xy_Te30 = my_eqn_to_xy(eqn_Te30, [0 -10]);


% Lagrange 승수법을 사용해서 곡선과 원점 사이의 최단거리를 구한다.
[ids_MTPA_10Nm, iqs_MTPA_10Nm, dist_1] = my_Lagrange_multiplier(eDiff(eqn_Te10), ids, iqs);
[ids_MTPA_20Nm, iqs_MTPA_20Nm, dist_2] = my_Lagrange_multiplier(eDiff(eqn_Te20), ids, iqs);
[ids_MTPA_30Nm, iqs_MTPA_30Nm, dist_3] = my_Lagrange_multiplier(eDiff(eqn_Te30), ids, iqs);
[ids_MTPA_40Nm, iqs_MTPA_40Nm, dist_4] = my_Lagrange_multiplier(eDiff(eqn_Te40), ids, iqs);

xy_const_torque = cell(1, 4);


% 전류제한원의 운전 영역.
theta = linspace(0, 2*pi, 1500);
xy_limit_circle = dist_4 * [cos(theta); sin(theta)]';

ids_ub = my_near_point_x_nx2(xy_limit_circle, [ids_MTPA_40Nm iqs_MTPA_40Nm]);
ids_lb = my_near_point_x_nx2(xy_limit_circle, [MFPT_position(end,1) MFPT_position(end,2)]);

idx = xy_limit_circle(:,1) > ids_lb & ...
      xy_limit_circle(:,1) < ids_ub & ...
      xy_limit_circle(:,2) > 0;
xy_const_torque{4} = xy_limit_circle(idx,:);


% T=30Nm 곡선의 운전 영역.
ids_ub = my_near_point_x_nx2(xy_Te30, [ids_MTPA_30Nm iqs_MTPA_30Nm]);
ids_lb = my_near_point_x_fxy_gxy(xy_Te30, MFPT_position);
idx = xy_Te30(:,1) > ids_lb & xy_Te30(:,1) < ids_ub;

xy_const_torque{3} = xy_Te30(idx,:);


% T=20Nm 곡선의 운전 영역.
ids_ub = my_near_point_x_nx2(xy_Te20, [ids_MTPA_20Nm iqs_MTPA_20Nm]);
ids_lb = my_near_point_x_fxy_gxy(xy_Te20, MFPT_position);
idx = xy_Te20(:,1) > ids_lb & xy_Te20(:,1) < ids_ub;

xy_const_torque{2} = xy_Te20(idx,:);

% T=10Nm 곡선의 운전 영역.
ids_ub = my_near_point_x_nx2(xy_Te10, [ids_MTPA_10Nm iqs_MTPA_10Nm]);
ids_lb = my_near_point_x_fxy_gxy(xy_Te10, MFPT_position);
idx = xy_Te10(:,1) > ids_lb & xy_Te10(:,1) < ids_ub;
xy_const_torque{1} = xy_Te10(idx,:);

aa = [xy_const_torque{4}; MFPT_position];
%%% aa를 바꾸면 댐


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% view %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure; hold on;

title("전압제한타원과 전류제한원");
set(gcf, 'Name', 'Voltage and Current limit Analysis', 'NumberTitle', 'off');
xlabel('d-axis [A]'); ylabel('q-axis [A]')
axis([-10 2 -6 6]*1.5);
pbaspect([1 1 1])
plot([0 0], [-10 10] *1.5, 'k', 'LineWidth', 0.5);
plot([-10 10]*1.5, [0 0], 'k', 'LineWidth', 0.2);


% 전류제한원
f1te=fimplicit(eqn_Te10, 'color', [0.5 0.5 0.5]);
f2te=fimplicit(eqn_Te20, 'color', [0.5 0.5 0.5]);
f3te=fimplicit(eqn_Te30, 'color', [0.5 0.5 0.5]);
f4te=fimplicit(eqn_Te40, 'color', [0.5 0.5 0.5]);

f2di=fimplicit(ids^2+iqs^2==dist_2^2, 'color',[0.3 0.3 0.3]);
f3di=fimplicit(ids^2+iqs^2==dist_3^2, 'color',[0.3 0.3 0.3]);
f4di=fimplicit(ids^2+iqs^2==dist_4^2, color='k', linewidth=1.2, displayname='Current Constraint');
drawnow;
text(f1te.XData(end-3), f1te.YData(end-3),'Te=10Nm', 'backgroundColor', 'white', fontsize=12);
text(f2te.XData(end-6), f2te.YData(end-6),'Te=20Nm', 'backgroundColor', 'white', fontsize=12);
text(f3te.XData(end-9), f3te.YData(end-9),'Te=30Nm', 'backgroundColor', 'white', fontsize=12);
text(f4te.XData(end-15),f4te.YData(end-15),'Te=40Nm', 'backgroundColor', 'white', fontsize=12);

% operation point plot
f_MFPT = plot(MFPT_position(:,1), MFPT_position(:,2), 'g-', 'linewidth', 2, 'DisplayName', 'MFPT Points', 'displayname', 'MTPV');

f_limit = plot(xy_const_torque{4}(:,1), xy_const_torque{4}(:,2), 'r-', 'linewidth', 2);
f_Te30 = plot(xy_const_torque{3}(:,1), xy_const_torque{3}(:,2), 'r-', 'linewidth', 2);
f_Te20 = plot(xy_const_torque{2}(:,1), xy_const_torque{2}(:,2), 'r-', 'linewidth', 2);
f_Te10 = plot(xy_const_torque{1}(:,1), xy_const_torque{1}(:,2), 'r-', 'linewidth', 2);

f1MTPA = plot(MTPA_position(:,1), MTPA_position(:,2), 'linewidth', 2, 'color', 'b', 'displayname', 'MTPA: ~40Nm');

% parameter text
t2 = text(-14, -8, ' ', 'interpreter', 'latex', 'fontsize',12);
plot(-Lamf/Lds, 0, 'go', 'MarkerFaceColor', 'g');
text(-Lamf/Lds, -0.7, '$$(-\frac{\phi_f}{L_{ds}}, 0)$$', 'interpreter', 'latex');

% 전압제한타원
kk = plot(-100, -100, 'k--', 'displayname', 'Voltage Constraint');
f1= fimplicit(subs(w_eqn, w, wr_val(1)), 'k--');

legend([f1MTPA f_MFPT f4di kk], 'Location', 'northeastoutside')


for value=wr_val
    eqn = subs(w_eqn, w, value);
    f1.Function = subs(w_eqn, w, value);
    refreshdata(f1);
    drawnow;

    t2.String = ['$$' sprintf('w_{rpm} = %.0f', value * to_rpm / (P/2)) '\ RPM' '$$' '(~300 RPM)'];
    pause(0.1);
end




























% text(f3.XData(1), f3.YData(1),'w_{3}', 'backgroundColor', 'white', 'fontsize', 12);


% figure; % 그닥 중요하지 않은듯?
% title("MTPA power Analysis");
% plot(wrm_list, Pout, 'k.');
% xlabel("w_{rm} [rad/s]"), ylabel("P_{out} [W]")
% set(gcf, 'Name', 'MTPA power Analysis', 'NumberTitle', 'off'); 

%%
% lambda가 최소가 되는 ids를 구하자.
lambda = rhs(w_eqn);
lambda = sqrt(lambda);
iqs_ans = solve(Te_eqn, iqs); % 동토크 영역이므로 iqs는 ids로 표현할 수 있다.

lambda = subs(lambda, iqs, iqs_ans); % 3/2*P를 빼면 배박논(5-7)식과 동일함.
lambda_Te10 = subs(lambda, Te, 10);
lambda_Te20 = subs(lambda, Te, 20);
lambda_Te30 = subs(lambda, Te, 30);
lambda_Te40 = subs(lambda, Te, 40);

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

% MFPT의 전력 구하기
power_MFPT=[];
www = [];

function [wrm, power] = get_power_by_idqs(x, y, w_eqn, t_eqn, P)
    syms ids iqs
    wr = subs(w_eqn, [ids iqs], [x y]);
    tt = subs(t_eqn, [ids iqs], [x y]);
    wrm = double(wr) * 2/P;
    power = wrm * tt;
end

% for i=1:size(MTPA_position(:,1),1)
%     x = MTPA_position(i,1);
%     y = MTPA_position(i,2);
% 
%     [wrm, power] = get_power_by_idqs(x, y, w_solution, rhs(Te_eqn), P);
%     power_MFPT(end+1) = power;
%     www(end+1) = wrm;
% end
% for i=st:en 
%     x = xy_limit_circle(1,i);
%     y = xy_limit_circle(2,i);
% 
%     [wrm, power] = get_power_by_idqs(x, y, w_solution, rhs(Te_eqn), P);
%     power_MFPT(end+1) = power;
%     www(end+1) = wrm;
% end

% for i=st_te30:en_te30 
%     x = xy_Te30(1,i);
%     y = xy_Te30(2,i);
% 
%     [wrm, power] = get_power_by_idqs(x, y, w_solution, rhs(Te_eqn), P);
%     power_MFPT(end+1) = power;
%     www(end+1) = wrm;
% end

for i=1:size(MFPT_position(:,1),1)
    x = MFPT_position(i,1);
    y = MFPT_position(i,2);

    [wrm, power] = get_power_by_idqs(x, y, w_solution, rhs(Te_eqn), P);
    power_MFPT(end+1) = power;
    www(end+1) = wrm;
end

figure;
title("전압제한타원과 전류제한원");
set(gcf, 'Name', 'MTPA - limit Current Region - MFPT', 'NumberTitle', 'off');
plot(www(1:end-2), power_MFPT(1:end-2), 'r.')
axis([0 500 0 5800])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




% figure; hold on;
% set(gcf, 'Name', '토크 별 동작점의 이동에 따른 자속의 크기', 'NumberTitle', 'off');
% p1=plot(ids_, lambda_Te40_val, 'displayname', 'Te=40Nm');
% p2=plot(ids_, lambda_Te30_val, 'displayname', 'Te=30Nm');
% p3=plot(ids_, lambda_Te20_val, 'displayname', 'Te=20Nm');
% p4=plot(ids_, lambda_Te10_val, 'displayname', 'Te=10Nm');
% ylabel('|\lambda_{dqs}| [Wb]'), set(get(gca, 'YLabel'), 'Rotation', 0, 'VerticalAlignment', 'middle', 'HorizontalAlignment', 'right');
% xlabel("i_{ds} [A]");
% 
% plot(ids_(idx_Te10), lambda_Te10_val(idx_Te10), 'ro')
% plot(ids_(idx_Te20), lambda_Te20_val(idx_Te20), 'ro')
% plot(ids_(idx_Te30), lambda_Te30_val(idx_Te30), 'ro')
% plot(ids_(idx_Te40), lambda_Te40_val(idx_Te40), 'ro')
% legend([p1 p2 p3 p4]);
% title("토크 별 동작점의 이동에 따른 자속의 크기")