clear; close all;
syms Vsmax
syms Lqs Lds Lamf 
syms iqs ids w;
syms Te;
syms P;

to_rps = 2*pi/60;
to_rpm = 60/2/pi;

% fve40 example parameter
P = 24;
Lds = 30e-3;
Lqs = 30e-3;
Lamf = 0.28; % [Wb]
Vsmax = 60;
Ismax = 8; % Arms
eDiff = @(eqn) rhs(eqn) - lhs(eqn);

w_eqn = (Vsmax/w)^2 == (Lamf+Lds*ids)^2 + (Lqs*iqs)^2;
Te_eqn = Te == (ids*iqs*(Lds - Lqs) + Lamf*iqs)*3/2*P; 

w_solution = solve(w_eqn, w);
w_solution = w_solution(2); % 임시방편.

MFPT_position=[];
MTPA_position=[];
wrm_list=[];
Pout=[];

% 전류 제한원
eqn_Te40 = subs(Te_eqn, Te, 40);

% Lagrange 승수법을 사용해서 곡선과 원점 사이의 최단거리를 구한다.
[ids_MTPA_40Nm, iqs_MTPA_40Nm, dist_4] = my_Lagrange_multiplier(eDiff(eqn_Te40), ids, iqs);

xy_const_torque = cell(1, 4);

% 전류제한원의 운전 영역.
theta = linspace(0, 2*pi, 8000);
xy_limit_circle = dist_4 * [cos(theta); sin(theta)]';

ids_ub = my_near_point_x_nx2(xy_limit_circle, [ids_MTPA_40Nm iqs_MTPA_40Nm]);
ids_lb = my_near_point_x_nx2(xy_limit_circle, [-Lamf/Lds 0]);

idx = xy_limit_circle(:,1) > (ids_lb-0.5) & ...
      xy_limit_circle(:,1) < ids_ub & ...
      xy_limit_circle(:,2) > 0;
xy_const_torque{4} = xy_limit_circle(idx,:);

wrpm_val = 140:4:380;
wr_val = wrpm_val * to_rps * (P/2);
aa = xy_const_torque{4};

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% view %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure; hold on;

title("전압제한타원과 전류제한원");
set(gcf, 'Name', 'Voltage and Current limit Analysis', 'NumberTitle', 'off');
xlabel('d-axis [A]'); ylabel('q-axis [A]')
axis([-10 2 -6 6]*1.5);
pbaspect([1 1 1])
plot([0 0], [-15 15], 'k', 'LineWidth', 0.5);
plot([-15 15], [0 0], 'k', 'LineWidth', 0.2);

f1MTPA = plot([0 0], [0 4], 'b', 'LineWidth', 2, 'displayname', 'MTPA: ~40Nm');

f4di=fimplicit(ids^2+iqs^2==dist_4^2, color='k', linewidth=1.2, displayname='Current Constraint');
drawnow;

f_limit = plot(xy_const_torque{4}(:,1), xy_const_torque{4}(:,2), 'r-', 'linewidth', 2);

t2 = text(-14, -8, ' ', 'interpreter', 'latex', 'fontsize',12);
plot(-Lamf/Lds, 0, 'go', 'MarkerFaceColor', 'g');
text(-Lamf/Lds, -0.7, '$$(-\frac{\phi_f}{L_{ds}}, 0)$$', 'interpreter', 'latex');

% 전압제한타원
kk = plot(-100, -100, 'k--', 'displayname', 'Voltage Constraint');
f1= fimplicit(subs(w_eqn, w, wr_val(1)), 'k--');
legend([f1MTPA f4di kk], 'Location', 'northeastoutside')

OperPoint = plot(aa(1,1), aa(1,2), 'mo', 'MarkerFaceColor', 'm', 'displayname', 'Operating Point');

iqs_Te = solve(Te_eqn, iqs);

o = -Lamf/Lds;
for value=wr_val
    r = Vsmax/Lds/value;
    ids_value = linspace(min(o + r-1, -4), o + r+0.1, 80);
    
    iqs_syms = solve( subs(w_eqn, w, value), iqs ) ;
    iqs_value = subs( iqs_syms(2), ids, ids_value);

    ids_value = ids_value(imag(iqs_value) == 0);
    iqs_value = iqs_value(imag(iqs_value) == 0);
    
    [x, y] = my_near_point_x_fxy_gxy(aa, [ids_value; iqs_value]');

    if OperPoint.XData > x %가라
    OperPoint.XData = x;
    OperPoint.YData = y;
    end

    f1.Function = subs(w_eqn, w, value);
    refreshdata(f1);
    drawnow;

    torque = double( subs(rhs(Te_eqn), iqs ,y) );

    power = 1.5 * (value / (P/2)) * (torque) ;

    t2.String = ['$$' sprintf('w_{rpm} = %.0f', value * to_rpm / (P/2)) '\ RPM' '$$' ...
        '$$' sprintf('P_m = %.0f', power) '\ W' '$$'];
    pause(0);
end


























