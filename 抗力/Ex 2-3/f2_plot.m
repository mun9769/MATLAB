function [w_eqn, p_current, f1, t2] = f2_plot(Vdc, Lamf, Lds, Lqs, p, Is_Rated)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms iqs ids w;
syms Te;

eDiff = @(eqn) rhs(eqn) - lhs(eqn);

w_eqn = (Vdc/w)^2 == (Lamf+Lds*ids)^2 + (Lqs*iqs)^2; 
Te_eqn = Te == (ids*iqs*(Lds - Lqs) + Lamf*iqs)*3/2*p; 


% 전류 제한원
eqn_Te10 = subs(Te_eqn, Te, 10);
eqn_Te20 = subs(Te_eqn, Te, 20);
eqn_Te30 = subs(Te_eqn, Te, 30);
eqn_Te40 = subs(Te_eqn, Te, 64.5); % todo: ㅇ이름 변경
xy_Te10 = my_eqn_to_xy(eqn_Te10, [0 -10]);
xy_Te20 = my_eqn_to_xy(eqn_Te20, [0 -10]);
xy_Te30 = my_eqn_to_xy(eqn_Te30, [0 -10]);

% Lagrange 승수법을 사용해서 곡선과 원점 사이의 최단거리를 구한다.
[ids_MTPA_10Nm, iqs_MTPA_10Nm, dist_1] = my_Lagrange_multiplier(eDiff(eqn_Te10), ids, iqs);
[ids_MTPA_20Nm, iqs_MTPA_20Nm, dist_2] = my_Lagrange_multiplier(eDiff(eqn_Te20), ids, iqs);
[ids_MTPA_30Nm, iqs_MTPA_30Nm, dist_3] = my_Lagrange_multiplier(eDiff(eqn_Te30), ids, iqs);
[ids_MTPA_40Nm, iqs_MTPA_40Nm, dist_4] = my_Lagrange_multiplier(eDiff(eqn_Te40), ids, iqs);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fig = figure;
h_ax = axes(fig);
hold on;

title("전압제한타원과 전류제한원(T_e^{*} = 30Nm)");
set(gcf, 'Name', 'Voltage and Current limit Analysis', 'NumberTitle', 'off');
xlabel('d-axis [A]'); ylabel('q-axis [A]')
axis([-Is_Rated 5 -5 Is_Rated]*1.5);
pbaspect([1 1 1])
plot([0 0], [-Is_Rated Is_Rated] *1.5, 'k', 'LineWidth', 0.5);
plot([-Is_Rated Is_Rated]*1.5, [0 0], 'k', 'LineWidth', 0.2);


% 전류제한원
f1te=fimplicit(eqn_Te10, 'color', [0.5 0.5 0.5]);
f2te=fimplicit(eqn_Te20, 'color', [0.5 0.5 0.5]);
f3te=fimplicit(eqn_Te30, 'color', [0.5 0.5 0.5]);
f4te=fimplicit(eqn_Te40, 'color', [0.5 0.5 0.5]);

f2di=fimplicit(ids^2+iqs^2==dist_2^2, 'color',[0.3 0.3 0.3]);
f3di=fimplicit(ids^2+iqs^2==dist_3^2, 'color',[0.3 0.3 0.3]);
f4di=fimplicit(ids^2+iqs^2==Is_Rated^2, color='k', linewidth=1.2, displayname='Current Constraint');

drawnow;
text(f1te.XData(end-3), f1te.YData(end-3),'Te=10Nm', 'backgroundColor', 'white', fontsize=12);
text(f2te.XData(end-6), f2te.YData(end-6),'Te=20Nm', 'backgroundColor', 'white', fontsize=12);
text(f3te.XData(end-9), f3te.YData(end-9),'Te=30Nm', 'backgroundColor', 'white', fontsize=12);
text(f4te.XData(end-15),f4te.YData(end-15),'Te=64.5Nm', 'backgroundColor', 'white', fontsize=12);


% parameter text
t2 = text(-14, -8, ' ', 'interpreter', 'latex', 'fontsize',12);
plot(-Lamf/Lds, 0, 'go', 'MarkerFaceColor', 'g');
text(-Lamf/Lds, -0.7, '$$(-\frac{\phi_f}{L_{ds}}, 0)$$', 'interpreter', 'latex');

p_current = plot(0, 0, 'mo', 'MarkerFaceColor', 'm', 'displayname', 'Operating Point');

f1= fimplicit(subs(w_eqn, w, 530), 'k--'); % 20은  수정해야 함.



end