function [fig, t1, f1] = my_set_fig()

syms iqs ids w;
syms Te;


% fve40 example parameter
P = 24;
Lds = 30e-3;
Lqs = 40e-3;
Lamf = 0.12; % [Wb]
Vsmax = 60;
Ismax = 8; % Arms
eDiff = @(eqn) rhs(eqn) - lhs(eqn);

w_eqn = (Vsmax/w)^2 == (Lamf+Lds*ids)^2 + (Lqs*iqs)^2; 
Te_eqn = Te == (ids*iqs*(Lds - Lqs) + Lamf*iqs)*3/2*P; 

w_solution = solve(w_eqn, w);
w_solution = w_solution(2); % 임시방편.

MFPT_position=[];
MTPA_position=[];

if exist('data.mat', 'file')
    load('data.mat');
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
    save('data.mat', 'MTPA_position', '-append');
    save('data.mat', 'MFPT_position', '-append');
end

to_rps = 2*pi/60;
to_rpm = 60/2/pi;


% 전류 제한원
eqn_Te10 = subs(Te_eqn, Te, 10);
eqn_Te20 = subs(Te_eqn, Te, 20);
eqn_Te30 = subs(Te_eqn, Te, 30);
eqn_Te40 = subs(Te_eqn, Te, 40);


% Lagrange 승수법을 사용해서 곡선과 원점 사이의 최단거리를 구한다.
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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% view %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure; 
h_ax = axes(fig);
hold on;


title("IPMSM에서의 전압제한타원과 전류제한원");
set(gcf, 'Name', 'Voltage and Current limit Analysis', 'NumberTitle', 'off');
xlabel('d-axis [A]'); ylabel('q-axis [A]')
axis([-10 2 -6 6]*1.5);
pbaspect([1 1 1])
plot([0 0], [-10 10] *1.5, 'k', 'LineWidth', 0.5);
plot([-10 10]*1.5, [0 0], 'k', 'LineWidth', 0.2);


% const Torque Line
f1te=fimplicit(eqn_Te10, 'color', [0.5 0.5 0.5]);
f2te=fimplicit(eqn_Te20, 'color', [0.5 0.5 0.5]);
f3te=fimplicit(eqn_Te30, 'color', [0.5 0.5 0.5]);
f4te=fimplicit(eqn_Te40, 'color', [0.5 0.5 0.5]);
drawnow;

f4di=fimplicit(ids^2+iqs^2==dist_4^2, color='k', linewidth=1.2, displayname='Current Constraint');


text(f1te.XData(end-3), f1te.YData(end-3),'Te=10Nm', 'backgroundColor', 'white', fontsize=10);
text(f2te.XData(end-6), f2te.YData(end-6),'Te=20Nm', 'backgroundColor', 'white', fontsize=10);
text(f3te.XData(end-9), f3te.YData(end-9),'Te=30Nm', 'backgroundColor', 'white', fontsize=10);
text(f4te.XData(end-15),f4te.YData(end-15),'Te=40Nm', 'backgroundColor', 'white', fontsize=10);

% operation point plot
f_MFPT = plot(MFPT_position(:,1), MFPT_position(:,2), 'g-', 'linewidth', 2, 'DisplayName', 'MFPT Points', 'displayname', 'MTPV');

f_limit = plot(xy_const_torque{4}(:,1), xy_const_torque{4}(:,2), 'r-', 'linewidth', 2);

f1MTPA = plot(MTPA_position(:,1), MTPA_position(:,2), 'linewidth', 2, 'color', 'b', 'displayname', 'MTPA: ~40Nm');

% parameter text
plot(-Lamf/Lds, 0, 'go', 'MarkerFaceColor', 'g');
text(-Lamf/Lds, -0.7, '$$(-\frac{\phi_f}{L_{ds}}, 0)$$', 'interpreter', 'latex');




wrpm_val = 1;
wr_val = wrpm_val * to_rps * P;
f1= fimplicit(subs(w_eqn, w, wr_val), 'k--');

legend([f1MTPA f_MFPT f4di], 'Location', 'northeastoutside')


t1 = annotation(fig, 'textbox', [0.7541    0.1143    0.0752    0.0513], ...
    'String', '0.00 s', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle', ...
    'EdgeColor', 'none', ...  % 테두리 제거
    'FontSize', 12, ...
    'FontWeight', 'bold');



end