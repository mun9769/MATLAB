function [p_current, Mode, p, Lamf, Lds, Lqs, Rs, Is_Rated, Jm, Bm, Vdc, fsw, Tsw, fs, Ts, Lamf_Hat, Rs_Hat, Lds_Hat, Lqs_Hat, Jm_Hat, Bm_Hat, SpdObs, CC, Thetarm_Init, Wrm_Init, Wrm_Fin, Idqsr_Ref_Set, Step_Time, Stop_Time, f1, t2, w_eqn] = f1_param()
% todo: structure binding

clc
clear
close all
format short eng

% Simulation mode

Mode.PWM=1;         % PWM method
% 1: SCPWM, 2: 60deg DPWM, 3: 120deg(on) DPWM, 4: 120deg(off) DPWM
Mode.CC_Type=2;     % Current controller type
% 1: State feedback, 2: Complex vector
Mode.AntiWindup=1;  % Anti-windup
% 0: Off, 1: On

% Machine parameters

p=3;                        % # of pole pairs
Lamf=0.254;
Lds=3.6e-3;
Lqs=4.3e-3;
Rs=0.15;
Is_Rated=39.5*sqrt(2);      % Peak Value

Jm=0.01;
Bm=.018;

% System parameters

Vdc = 310;

fsw=10e3;       % Switching frequency
Tsw=1/fsw;      % Switching period

fs=2*fsw;       % Samping frequency (double sampling)
Ts=1/fs;        % Samping period

% Estimated parameters

Lamf_Hat=1.0*Lamf;
Rs_Hat=1.0*Rs;
Lds_Hat=1.0*Lds;
Lqs_Hat=1.0*Lqs;
Jm_Hat=1.0*Jm;
Bm_Hat=1.0*Bm;

% Controller setting

SpdObs.Wn=100*2*pi;         % Speed observer Imag pole
SpdObs.Zeta=1;
SpdObs.P=-1.3*SpdObs.Wn;    % Speed observer real pole

SpdObs.L1=2*SpdObs.Zeta*SpdObs.Wn-SpdObs.P-Bm_Hat/Jm_Hat;
SpdObs.L2=SpdObs.Wn^2-2*SpdObs.Zeta*SpdObs.Wn*SpdObs.P-SpdObs.L1*Bm_Hat/Jm_Hat;
SpdObs.L3=-SpdObs.Wn^2*SpdObs.P;

CC.Wc=500*2*pi;             % Current controller BW
CC.Is_lim=Is_Rated;         % Current constraint
CC.Ra=10*Rs_Hat;            % Active damping

CC.Kp_Mat=CC.Wc*[Lds_Hat 0;0 Lqs_Hat];
CC.Ki_Mat=CC.Wc*(Rs_Hat+CC.Ra)*eye(2);
CC.Ka_Mat=inv(CC.Kp_Mat);

% Command setting

Thetarm_Init=0*pi*1/p;

Wrm_Init=1700*2*pi/60;
Wrm_Fin=1700*2*pi/60;

Idqsr_Ref_Set=[0 -5;0 50];

Step_Time=0.01;
Stop_Time=0.04;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

syms iqs ids w;
syms Te;

eDiff = @(eqn) rhs(eqn) - lhs(eqn);

w_eqn = (Vdc/w)^2 == (Lamf+Lds*ids)^2 + (Lqs*iqs)^2; 
Te_eqn = Te == (ids*iqs*(Lds - Lqs) + Lamf*iqs)*3/2*p; 

w_solution = solve(w_eqn, w);
w_solution = w_solution(2); % 임시방편.

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

title("IPMSM에서의 전압제한타원과 전류제한원(T_e^{*} = 30Nm)");
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


