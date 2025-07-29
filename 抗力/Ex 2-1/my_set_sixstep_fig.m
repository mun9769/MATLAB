
function [fig, ha, Sabc, Vdqss_Ref, ta, ps, text, arrow] = my_set_sixstep_fig(logsout)
global Vdc
Vdqss_Ref =  logsout.get("Vdqss_Ref").Values.Data;
tt =         logsout.get("Vdqss_Ref").Values.Time;

Sabc =  logsout.get("Sabc").Values.Data ;
ta =    logsout.get("Sabc").Values.Time;

Vdqss_Ref = interp1(tt, Vdqss_Ref, ta, 'previous');
Vdqss_Ref( isnan(Vdqss_Ref) ) = 0;

for ii=1:length(Sabc)
    Sabc(ii,1) = Sabc(ii,1) + Sabc(ii,2)*2 + Sabc(ii,3)*4; % todo: 꺼꾸로 했나?
end

a = pi/3;
%        1      2       3        4        5        6        7
vol = [cos(0) cos(a) cos(2*a) cos(3*a) cos(4*a) cos(5*a) cos(0);
       sin(0) sin(a) sin(2*a) sin(3*a) sin(4*a) sin(5*a) sin(0)]';
vol = vol * Vdc * 2/3;

fig = figure;
ha = axes(fig);
hold(ha, 'on');
axis equal
pbaspect(ha, [1 1 1]);
% ha.Position = [  0.0777    0.5642    0.3540    0.3879];

plot(ha, vol(:,1), vol(:,2), 'k-');

text = annotation(fig, 'textbox', [0.8    0.1143    0.10    0.05], ...
    'String', '0.00 s', ...
    'EdgeColor', 'none', ...  % 테두리 제거
    'FontSize', 12, ...
    'FontWeight', 'bold');

arrow = quiver(0, 0, 0, 0); % todo: quiver


ps = cell(1,7);

ps{1}= plot(ha, vol(1,1), vol(1,2), 'ro', 'MarkerFaceColor','white');

ps{2}= plot(ha, vol(3,1), vol(3,2), 'ro', 'MarkerFaceColor','white');
ps{3}= plot(ha, vol(2,1), vol(2,2), 'ro', 'MarkerFaceColor','white');
ps{4}= plot(ha, vol(6,1), vol(6,2), 'ro', 'MarkerFaceColor','white');
ps{5}= plot(ha, vol(4,1), vol(4,2), 'ro', 'MarkerFaceColor','white');
ps{6}= plot(ha, vol(5,1), vol(5,2), 'ro', 'MarkerFaceColor','white');

ps{7}= plot(ha, 0,0,'ro','markerfacecolor','white');

end