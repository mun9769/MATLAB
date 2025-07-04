clear; close all;
syms Vsmax
syms Lqs Lds Lamf 
syms iqs ids w;
syms Te;

eDiff = @(eqn) rhs(eqn) - lhs(eqn);

if exist('data.mat', 'file')
    load('data.mat'); % MTPA_position 계산이 오래걸려서 data.mat에 저장시킨다.
    % save('data.mat', 'MTPA_position');
end

% IPMSM matlab example parameter
Vsmax = 20 / sqrt(3);
P = 8;
Lds = 0.298e-3;
Lqs = 0.298e-3;
Lamf = 0.04366;

% fve40 example parameter
P = 24;
Lds = 30e-3;
Lqs = 30e-3;
Lamf = 0.32; % [Wb] % 이거만 0.2 키움
Vsmax = 400;
Ismax = 10; % Arms
% wrpm_rated = 400; % rpm

% 전압 제한원
eqn = (Vsmax/w)^2 == (Lamf+Lds*ids)^2 + (Lqs*iqs)^2;
wrpm_val = [1000 1200 1400 1600 1800];
wr_val = wrpm_val*(2*pi/60) * (P/2);  
w_eqn1=subs(eqn, w, wr_val(3));
w_eqn2=subs(eqn, w, wr_val(4));
w_eqn3=subs(eqn, w, wr_val(5));
w_solution = solve(eqn, w);

% 전류 제한원
eqn = Te == 3/2*P * (ids*iqs*(Lds - Lqs) + Lamf*iqs);
Te_eqn1 = subs(eqn, Te, 10);
Te_eqn2 = subs(eqn, Te, 20);
Te_eqn3 = subs(eqn, Te, 30);
Te_eqn4 = subs(eqn, Te, 40);
% Lagrange 승수법을 사용해서 곡선과 원점 사이의 최단거리를 구한다.
[~, ~, dist_1] = my_Lagrange_multiplier(eDiff(Te_eqn1), ids, iqs);
[~, ~, dist_2] = my_Lagrange_multiplier(eDiff(Te_eqn2), ids, iqs);
[~, ~, dist_3] = my_Lagrange_multiplier(eDiff(Te_eqn3), ids, iqs);
[ids_mn, iqs_mn, dist_4] = my_Lagrange_multiplier(eDiff(Te_eqn4), ids, iqs);
circle_eqn1 = ids^2+iqs^2 == dist_4^2;


% 전압제한원과 전류제한원의 교점 구하기. -> none
[sol_ids, sol_iqs] = solve([w_eqn3 circle_eqn1], [ids iqs]);
sol_ids = double(sol_ids);
sol_iqs = double(sol_iqs);
sol_ids = sol_ids(1);
sol_iqs = sol_iqs(1);
a = [sol_ids sol_iqs];
b = [ids_mn iqs_mn];


if ~exist('MTPA_position', 'var')
    for te=1:40
        eqn = subs(eqn, Te, te);
        [x_mn, y_mn, dist] = my_Lagrange_multiplier(eDiff(eqn), ids, iqs);
        MTPA_position(te,:) = [x_mn y_mn];
        
        wrm = subs(w_solution, [ids iqs], [x_mn y_mn]);
        wrm = wrm(wrm>0);
        wrm = double(wrm) / (P/2);
        Pout(te) = wrm * te;
    end
end

figure;
plot(1:40, Pout, 'k');
xlabel("T_e [Nm]"); ylabel("P_{out} [W]")
title("MTPA power");

figure; hold on;
f3=fimplicit(w_eqn3, 'k--');
f4=plot(-Lamf/Lds, 0, 'ro', displayname='전압제한타원 원점');
drawnow;

text(f3.XData(1), f3.YData(1),'w_{base}', 'backgroundColor', 'white', fontsize=12);

xlabel('d-axis'); ylabel('q-axis')
axis([-Ismax 2 -6 6]*1.5)
pbaspect([1 1 1])
plot([0 0], [-Ismax Ismax] *1.5, 'k', 'LineWidth', 0.5);
plot([-Ismax Ismax]*1.5, [0 0], 'k', 'LineWidth', 0.2);

 
% figure; hold on;
f4te=fimplicit(Te_eqn4, color='k');

f4di=fimplicit(ids^2+iqs^2==dist_4^2, color='k');

f1MTPA=plot(MTPA_position(:,1), MTPA_position(:,2), linewidth=2, color='b');
drawnow;

% text(f4te.XData(end-15),f4te.YData(end-15),'Te=40Nm', 'backgroundColor', 'white', fontsize=12);
text(MTPA_position(end,1), MTPA_position(end,2), 'MTPA: ~40Nm', ...
    backgroundcolor='white', ...
    fontsize=12, color='b');

xlabel('d-axis'); ylabel('q-axis')
axis([-Ismax 2 -6 6]*1.5)
pbaspect([1 1 1])
plot([0 0], [-Ismax Ismax] *1.5, 'k', 'LineWidth', 0.5);
plot([-Ismax Ismax]*1.5, [0 0], 'k', 'LineWidth', 0.2); 


param_str = sprintf(...
    'Lds = %.2f mH, Lqs = %.2f mH\nLamf = %.2f Wb, P = %d, Vsmax = %.0f V', ...
    Lds*1e3, Lqs*1e3, Lamf, P, Vsmax);

text(-14, -8, param_str, ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'middle', ...
    'FontSize', 10, ...
    'Interpreter', 'none');


