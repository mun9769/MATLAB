
function [fig, ha, ps, text, arrow, pcur] = my_set_sixstep_fig(ta, Sabc)

a = pi/3;
%        1      2       3        4        5        6        7
vol = [cos(0) cos(a) cos(2*a) cos(3*a) cos(4*a) cos(5*a) cos(0);
       sin(0) sin(a) sin(2*a) sin(3*a) sin(4*a) sin(5*a) sin(0)]';
vol = vol * 2/3 * 310; % todo: Vdc


fig = figure;
ha = axes(fig);
hold(ha, 'on');
axis equal
pbaspect(ha, [1 1 1]);
ha.Position = [0.0376    0.3214    0.5610    0.6148];
plot(ha, vol(:,1), vol(:,2), 'k-');

text = annotation(fig, 'textbox', [0.8    0.8143    0.10    0.05], ...
    'String', '0.00 s', ...
    'FontSize', 12, ...
    'FontWeight', 'bold');

arrow = quiver(ha, 0, 0, 0, 0); % todo: quiver

ps = cell(1,7);

ps{1}= plot(ha, vol(1,1), vol(1,2), 'ro', 'MarkerFaceColor','white');
ps{2}= plot(ha, vol(3,1), vol(3,2), 'ro', 'MarkerFaceColor','white');
ps{3}= plot(ha, vol(2,1), vol(2,2), 'ro', 'MarkerFaceColor','white');
ps{4}= plot(ha, vol(6,1), vol(6,2), 'ro', 'MarkerFaceColor','white');
ps{5}= plot(ha, vol(4,1), vol(4,2), 'ro', 'MarkerFaceColor','white');
ps{6}= plot(ha, vol(5,1), vol(5,2), 'ro', 'MarkerFaceColor','white');
ps{7}= plot(ha, 0, 0,'ro','markerfacecolor','white');


%%%%%%%%%%%% hb
hb = axes(fig);
hb.Position = [30.5677e-003    33.8323e-003   919.2140e-003   205.5888e-003];
hold(hb, 'on');
plot(hb, ta, Sabc(:,1));
pcur = plot(hb, 0, 0, 'b*');


end
