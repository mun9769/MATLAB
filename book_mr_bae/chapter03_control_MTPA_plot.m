clear; close all;
syms Vsmax
syms w Lqs Lds iqs ids phi;
syms Te;

eDiff = @(eqn) rhs(eqn) - lhs(eqn);

if exist('data.mat', 'file')
    load('data.mat'); % MTPA_position 계산이 오래걸려서 data.mat에 저장시킨다.
end

Vsmax = 20 / sqrt(3);
P = 8;
Lds = 0.243e-3;
Lqs = 0.298e-3;
phi = 0.04366;

Ismax = 400 / sqrt(2); % Arms
Tmax = 205; % Nm


% 전압 제한원
eqn = (Vsmax/w)^2 == (phi+Lds*ids)^2 + (Lqs*iqs)^2;

eqn_plot1=subs(eqn, w, 2*pi*60);
eqn_plot2=subs(eqn, w, 2*pi*120);

% 전류 제한원
eqn = Te == 3/2*P * (ids*iqs*(Lds - Lqs) + phi*iqs);

eqn_plot3 = subs(eqn, Te, 100);
eqn_plot4 = subs(eqn, Te, 200);


% Lagrange 승수법을 사용해서 곡선과 원점 사이의 최단거리를 구한다.
[~, ~, dist_3] = my_Lagrange_multiplier(eDiff(eqn_plot3), ids, iqs);
[ids_mn, iqs_mn, dist_4] = my_Lagrange_multiplier(eDiff(eqn_plot4), ids, iqs);

if ~exist('MTPA_position', 'var')
    for te=1:1800
        eqn_plot = subs(eqn, Te, te);

        [x_mn, y_mn, dist] = my_Lagrange_multiplier(eDiff(eqn_plot), ids, iqs);
        MTPA_position(te,:) = [x_mn y_mn];
    end
end


figure; hold on;
% plot([0 0], [-75 75], 'k', 'LineWidth', 0.5);  % 검은색 점선
% plot([-100 50], [0 0], 'k', 'LineWidth', 0.2);  % 검은색 점선

f1=fimplicit(eqn_plot1, 'k--');%, displayname='w=120\pi rad/s');
f2=fimplicit(eqn_plot2, 'k--');%, displayname='w=240\pi rad/s');
f3=plot(-phi/Lds, 0, 'r.', displayname='전압제한타원 원점');
drawnow;

% text(f1.XData(1), f1.YData(1),'w_{1}', 'backgroundColor', 'white', fontsize=16);%'w=120\pi rad/s', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom');
% text(f2.XData(1), f2.YData(1),'w_{2}', 'backgroundColor', 'white', fontsize=16);%'w=240\pi rad/s', 'HorizontalAlignment', 'left', 'VerticalAlignment', 'bottom');

% text(-50, -60, 'w_1 < w_2','FontSize', 22);
% text(-phi/Lds, -3, '(phi/Lds, 0)', 'horizontalalignment', 'center');

xlabel('d-axis'); ylabel('q-axis')
axis([-Ismax*1.5 50 -50 Ismax*1.5])
hold off;

%%
figure; hold on; % todo: x,y축 범위줄이기
plot([0 0], [-75 75], 'k', 'LineWidth', 0.5);  
plot([-100 50], [0 0], 'k', 'LineWidth', 0.2);  

f1=fimplicit(eqn_plot3, displayname='Te=500Nm');
f2=fimplicit(eqn_plot4, displayname='Te=800Nm');
f3=fimplicit(ids^2+iqs^2==dist_3^2, displayname='전류원1');
f4=fimplicit(ids^2+iqs^2==dist_4^2, displayname='전류원2');
f5=plot(MTPA_position(:,1), MTPA_position(:,2), linewidth=2, displayname='MTPA: ~1800Nm');
drawnow;
% text(ids_mn, iqs_mn, '최소전류지점');

axis([-100 50 -75 75])
pbaspect([1 1 1])

xlabel('d-axis'); ylabel('q-axis')
%%
subplot(7, 2, [13 14]); axis off;

param_str = sprintf(...
    'Lds = %.2f mH, Lqs = %.2f mH\n phi = %.1f Wb, P = %d, Vsmax = %.0f V', ...
    0.03e-3*1e6, 0.04e-3*1e6, 1, 16, 40);

text(0.5, 0.5, param_str, ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'middle', ...
    'FontSize', 10, ...
    'Interpreter', 'none');






