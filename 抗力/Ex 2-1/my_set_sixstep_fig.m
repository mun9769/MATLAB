
function [fig, ha, Sabc, Vdqss_Ref, ta, ps, text] = my_set_sixstep_fig(logsout)
global Vdc
Vdqss_Ref =  logsout.get("Vdqss_Ref").Values.Data;
tt =         logsout.get("Vdqss_Ref").Values.Time;

Sabc =  logsout.get("Sabc").Values.Data ;
ta =    logsout.get("Sabc").Values.Time;

Vdqss_Ref = interp1(tt, Vdqss_Ref, ta, 'previous');
Vdqss_Ref( isnan(Vdqss_Ref) ) = 0;

for ii=1:length(Sabc)
    Sabc(ii,1) = Sabc(ii,1)*4 + Sabc(ii,2)*2 + Sabc(ii,1); % todo: 꺼꾸로 했나?
end

a = pi/3;
vol = Vdc*2/3*[cos(0) cos(a) cos(2*a) cos(3*a) cos(4*a) cos(5*a) cos(0);
               sin(0) sin(a) sin(2*a) sin(3*a) sin(4*a) sin(5*a) sin(0)]';
%                1      2       3        4        5        6        7
fig = figure;
ha = axes(fig);
hold(ha, 'on');
plot(ha, vol(2:end,1), vol(2:end,2), 'k-');
axis equal
pbaspect(ha, [1 1 1]);
% ha.Position = [  0.0777    0.5642    0.3540    0.3879];

plot(ha, vol(:,1), vol(:,2), 'k-');

text = annotation(fig, 'textbox', [0.7541    0.1143    0.0752    0.0513], ...
    'String', '0.00 s', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle', ...
    'EdgeColor', 'none', ...  % 테두리 제거
    'FontSize', 12, ...
    'FontWeight', 'bold');

ps = cell(1,7);
for i = 1:6
    ps{i}= plot(ha, vol(i,1), vol(i,2), 'ro', 'MarkerFaceColor','r');
end
ps{7} = plot(ha,0,0,'ro','markerfacecolor','r');

end