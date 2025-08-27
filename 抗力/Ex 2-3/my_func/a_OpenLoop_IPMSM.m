clear; close all;


MFPT_position=[];
MTPA_position=[];
wrm_list=[];
Pout=[];

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




% 전류제한원의 운전 영역.
theta = linspace(0, 2*pi, 1500);
xy_limit_circle = dist_4 * [cos(theta); sin(theta)]';

ids_ub = my_near_point_x_nx2(xy_limit_circle, [ids_MTPA_40Nm iqs_MTPA_40Nm]);
ids_lb = my_near_point_x_nx2(xy_limit_circle, [MFPT_position(end,1) MFPT_position(end,2)]);

idx = xy_limit_circle(:,1) > ids_lb & ...
      xy_limit_circle(:,1) < ids_ub & ...
      xy_limit_circle(:,2) > 0;
xy_const_torque{4} = xy_limit_circle(idx,:);


% T=30Nm 곡선의 운전 영역.
ids_ub = my_near_point_x_nx2(xy_Te30, [ids_MTPA_30Nm iqs_MTPA_30Nm]);
ids_lb = my_near_point_x_fxy_gxy(xy_Te30, MFPT_position);
idx = xy_Te30(:,1) > ids_lb & xy_Te30(:,1) < ids_ub;
xy_const_torque{3} = xy_Te30(idx,:);

% T=20Nm 곡선의 운전 영역.
ids_ub = my_near_point_x_nx2(xy_Te20, [ids_MTPA_20Nm iqs_MTPA_20Nm]);
ids_lb = my_near_point_x_fxy_gxy(xy_Te20, MFPT_position);
idx = xy_Te20(:,1) > ids_lb & xy_Te20(:,1) < ids_ub;
xy_const_torque{2} = xy_Te20(idx,:);

% T=10Nm 곡선의 운전 영역.
ids_ub = my_near_point_x_nx2(xy_Te10, [ids_MTPA_10Nm iqs_MTPA_10Nm]);
ids_lb = my_near_point_x_fxy_gxy(xy_Te10, MFPT_position);
idx = xy_Te10(:,1) > ids_lb & xy_Te10(:,1) < ids_ub;
xy_const_torque{1} = xy_Te10(idx,:);




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% view %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% operation point plot
f_MFPT = plot(MFPT_position(:,1), MFPT_position(:,2), 'g-', 'linewidth', 2, 'DisplayName', 'MFPT Points', 'displayname', 'MTPV');

f_limit = plot(xy_const_torque{4}(:,1), xy_const_torque{4}(:,2), 'r-', 'linewidth', 2);
f_Te30 = plot(xy_const_torque{3}(:,1), xy_const_torque{3}(:,2), 'r-', 'linewidth', 2);
f_Te20 = plot(xy_const_torque{2}(:,1), xy_const_torque{2}(:,2), 'r-', 'linewidth', 2);
f_Te10 = plot(xy_const_torque{1}(:,1), xy_const_torque{1}(:,2), 'r-', 'linewidth', 2);

f1MTPA = plot(MTPA_position(:,1), MTPA_position(:,2), 'linewidth', 2, 'color', 'b', 'displayname', 'MTPA: ~40Nm');




wrpm_val = 100:1:300;
wr_val = wrpm_val * to_rps * P;
aa = [xy_const_torque{3}; MFPT_position];



% 전압제한타원
kk = plot(-100, -100, 'k--', 'displayname', 'Voltage Constraint');
f1= fimplicit(subs(w_eqn, w, wr_val(1)), 'k--');
legend([f1MTPA f_MFPT f4di kk], 'Location', 'northeastoutside')
kkk = plot(aa(1,1), aa(1,2), 'mo', 'MarkerFaceColor', 'm', 'displayname', 'Operating Point');


ids_value = linspace(-6, -2, 40);


if record == 1
vidObj = VideoWriter('te30_IPMSM.mp4');
open(vidObj);
end

for value=wr_val
    iqs_syms = solve( subs(w_eqn, w, value), iqs ) ;
    iqs_value = subs( iqs_syms(2), ids, ids_value);
    iqs_value = double(iqs_value);

    [x, y] = my_near_point_x_fxy_gxy(aa, [ids_value; iqs_value]');

    kkk.XData = x;
    kkk.YData = y;

    f1.Function = subs(w_eqn, w, value);
    refreshdata(f1);
    drawnow;

    t2.String = ['$$' sprintf('w_{rpm} = %.0f', value * to_rpm / P) '\ RPM' '$$' '(~300 RPM)'];
    % pause(0);
    if record == 1
    currFrame = getframe(fig);
    writeVideo(vidObj, currFrame);
    end
end

if record == 1
close(vidObj);
end



%%
% lambda가 최소가 되는 ids를 구하자.
lambda = rhs(w_eqn);
lambda = sqrt(lambda);
iqs_ans = solve(Te_eqn, iqs); % 동토크 영역이므로 iqs는 ids로 표현할 수 있다.

lambda = subs(lambda, iqs, iqs_ans); % 3/2*P를 빼면 배박논(5-7)식과 동일함.

figure; hold on;
set(gcf, 'Name', '토크 별 동작점의 이동에 따른 자속의 크기', 'NumberTitle', 'off');
% title("토크 별 동작점의 이동에 따른 자속의 크기")
ylabel('|\lambda_{dqs}| [Wb]'), set(get(gca, 'YLabel'), 'Rotation', 0, 'VerticalAlignment', 'middle', 'HorizontalAlignment', 'right');
xlabel("i_{ds} [A]");

plots = cell(1, 40);
MFPTs=[];
for te=1:40
    lambda_te = subs(lambda, Te, te);
    
    ids_ = linspace(-10, 0 ,200);
    lambda_te_val = double( subs(lambda_te, ids, ids_) );
    [~, idx_te] = min(lambda_te_val);

    iqs_te = subs(iqs_ans, [ids Te], [ids_(idx_te) te]);


    plots{te}=plot(ids_, lambda_te_val);%, 'displayname', 'Te=10Nm');
    MFPTs(te,:) = [ids_(idx_te), lambda_te_val(idx_te)];
    % plot(ids_(idx_te), lambda_te_val(idx_te), 'r.');%, 'MarkerFaceColor', 'r')
end
ff = plot(MFPTs(:,1), MFPTs(:,2), 'r-', 'linewidth',2, 'displayname', "MFPT Line");
kk = legend([ff]);%, '')


%% MFPT의 전력 구하기
power_MFPT=[];
www = [];

function [wrm, power] = get_power_by_idqs(x, y, w_eqn, t_eqn, P)
    syms ids iqs
    wr = subs(w_eqn, [ids iqs], [x y]);
    tt = subs(t_eqn, [ids iqs], [x y]);
    wrm = double(wr) * 2/P;
    power = wrm * tt;
end


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
axis([0 500 0 1000])
