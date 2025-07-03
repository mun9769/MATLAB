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
Lds = 0.243e-3;
Lqs = 0.298e-3;
Lamf = 0.04366;

% fve40 example parameter
P = 24;
Lds = 30e-3;
Lqs = 40e-3;
Lamf = 0.12; % [Wb]
Vsmax = 400;
Ismax = 10; % Arms
% wrpm_rated = 400; % rpm

% 전압 제한원
eqn = (Vsmax/w)^2 == (Lamf+Lds*ids)^2 + (Lqs*iqs)^2;
wrpm_val = [1000 1200 1400 1600 1800];
wr_val = wrpm_val*(2*pi/60) * (P/2);  
w_plot1=subs(eqn, w, wr_val(3)); 
w_plot2=subs(eqn, w, wr_val(4)); 
w_plot3=subs(eqn, w, wr_val(5)); 

% 전류 제한원
eqn = Te == 3/2*P * (ids*iqs*(Lds - Lqs) + Lamf*iqs);
Te_plot1 = subs(eqn, Te, 10);
Te_plot2 = subs(eqn, Te, 20);
Te_plot3 = subs(eqn, Te, 30);
% Lagrange 승수법을 사용해서 곡선과 원점 사이의 최단거리를 구한다.
[~, ~, dist_1] = my_Lagrange_multiplier(eDiff(Te_plot1), ids, iqs);
[~, ~, dist_2] = my_Lagrange_multiplier(eDiff(Te_plot2), ids, iqs);
[~, ~, dist_3] = my_Lagrange_multiplier(eDiff(Te_plot3), ids, iqs);


if ~exist('MTPA_position', 'var')
    for te=1:100
        eqn_plot = subs(eqn, Te, te);

        [x_mn, y_mn, dist] = my_Lagrange_multiplier(eDiff(eqn_plot), ids, iqs);
        MTPA_position(te,:) = [x_mn y_mn];
    end
end


figure; hold on;
f1=fimplicit(w_plot1, 'k--');
f2=fimplicit(w_plot2, 'k--');
f3=fimplicit(w_plot3, 'k--');
f4=plot(-Lamf/Lds, 0, 'ro', displayname='전압제한타원 원점');
drawnow;

text(f1.XData(round(end/2)), f1.YData(round(end/2)),'w_{1}', 'backgroundColor', 'white', fontsize=12);
text(f2.XData(round(end/2)), f2.YData(round(end/2)),'w_{2}', 'backgroundColor', 'white', fontsize=12);
text(f3.XData(round(end/2)), f3.YData(round(end/2)),'w_{3}', 'backgroundColor', 'white', fontsize=12);

xlabel('d-axis'); ylabel('q-axis')
axis([-Ismax 2 -Ismax Ismax]*1.5)
pbaspect([1 1 1])
plot([0 0], [-Ismax Ismax] *1.5, 'k', 'LineWidth', 0.5);
plot([-Ismax Ismax]*1.5, [0 0], 'k', 'LineWidth', 0.2);
% hold off;
% 
% %%
% figure; hold on;

f1=fimplicit(Te_plot1, color='k');
f2=fimplicit(Te_plot2, color='k');
f3=fimplicit(Te_plot3, color='k');
% f4=fimplicit(ids^2+iqs^2==dist_1^2, color='k');
f5=fimplicit(ids^2+iqs^2==dist_2^2, color='k');
f6=fimplicit(ids^2+iqs^2==dist_3^2, color='k');
f7=plot(MTPA_position(:,1), MTPA_position(:,2), linewidth=2, color='b');
drawnow;

text(f1.XData(end-3), f1.YData(end-3),'Te=10Nm', 'backgroundColor', 'white', fontsize=12);
text(f2.XData(end-6), f2.YData(end-6),'Te=20Nm', 'backgroundColor', 'white', fontsize=12);
text(f3.XData(end-9), f3.YData(end-9),'Te=30Nm', 'backgroundColor', 'white', fontsize=12);
text(MTPA_position(end,1), MTPA_position(end,2), 'MTPA: ~100Nm', ...
    backgroundcolor='white', ...
    fontsize=12, color='b');

xlabel('d-axis'); ylabel('q-axis')
axis([-Ismax 2 -6 6]*1.5)
pbaspect([1 1 1])
plot([0 0], [-Ismax Ismax] *1.5, 'k', 'LineWidth', 0.5);
plot([-Ismax Ismax]*1.5, [0 0], 'k', 'LineWidth', 0.2); 

%%
subplot(7, 2, [13 14]); axis off;

param_str = sprintf(...
    'Lds = %.2f mH, Lqs = %.2f mH\n Lamf = %.1f Wb, P = %d, Vsmax = %.0f V', ...
    0.03e-3*1e6, 0.04e-3*1e6, 1, 16, 40);

text(0.5, 0.5, param_str, ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'middle', ...
    'FontSize', 10, ...
    'Interpreter', 'none');






