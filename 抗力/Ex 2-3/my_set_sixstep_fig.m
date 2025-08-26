
function [fig, ha, ps, t_cnt, q_Vdqss_ref, q_Vdqss_ref_of, p_cur, p_avg, q_diff] = my_set_sixstep_fig(ta, Sabc,Vdc)

a = pi/3;
%        1      2       3        4        5        6        7
vol = [cos(0) cos(a) cos(2*a) cos(3*a) cos(4*a) cos(5*a) cos(0);
       sin(0) sin(a) sin(2*a) sin(3*a) sin(4*a) sin(5*a) sin(0)]';
vol = vol * 2/3 * Vdc; % todo: Vdc


fig = figure;
ha = axes(fig);
hold(ha, 'on');
axis(ha, [-Vdc, Vdc, -Vdc, Vdc])
axis equal
pbaspect(ha, [1 1 1]);
ha.Position = [0.0376    0.3214    0.6610    0.7148];
plot(ha, vol(:,1), vol(:,2), 'k-');

t_cnt = annotation(fig, 'textbox', [0.8    0.8143    0.15    0.05], ...
    'String', '', 'FontSize', 12, 'FontWeight', 'bold');

q_Vdqss_ref = annotation('arrow');
set(q_Vdqss_ref, 'parent', ha, 'position', [0 0 0 0], ...
    'headlength', 10, 'headwidth', 5, 'headstyle', 'cback1');
q_Vdqss_ref.Color = 'b';


q_Vdqss_ref_of = annotation('arrow');
set(q_Vdqss_ref_of, 'parent', ha, 'position', [0 0 0 0], ...
    'headlength', 10, 'headwidth', 5, 'headstyle', 'cback1');
q_Vdqss_ref_of.Color = 'cyan';


q_diff = annotation('arrow');
set(q_diff, 'parent', ha, 'position', [0 0 0 0], ...
    'headlength', 0, 'headwidth', 5, 'headstyle', 'cback1');
q_diff.Color = 'r';

p_avg = plot(ha, 0,0, 'ko','markersize',8, 'markerfacecolor', 'k');%,'color','g', 'markerfacecolor', 'g', 'displayname', 'average point');


ps = cell(1,7);

ps{1}= plot(ha, vol(1,1), vol(1,2), 'ro', 'MarkerFaceColor','white');
ps{3}= plot(ha, vol(2,1), vol(2,2), 'ro', 'MarkerFaceColor','white');
ps{2}= plot(ha, vol(3,1), vol(3,2), 'ro', 'MarkerFaceColor','white');
ps{6}= plot(ha, vol(4,1), vol(4,2), 'ro', 'MarkerFaceColor','white');
ps{4}= plot(ha, vol(5,1), vol(5,2), 'ro', 'MarkerFaceColor','white');
ps{5}= plot(ha, vol(6,1), vol(6,2), 'ro', 'MarkerFaceColor','white');
ps{7}= plot(ha, 0, 0,'ro','markerfacecolor','white');


%%%%%%%%%%%% hb
hb = axes(fig);
hb.Position = [30.5677e-003    33.8323e-003   919.2140e-003   205.5888e-003];
hold(hb, 'on');
plot(hb, ta, Sabc(:,1), 'b.');
p_cur = plot(hb, 0, 0, 'b*');


end
