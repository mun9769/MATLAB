
function [fig, ha, Sabc, Vdqss_Ref, ta, ps] = my_set_sixstep_fig(logsout)
global Vdc
Vdqss_Ref =  logsout.get("Vdqss_Ref").Values.Data;
tt =         logsout.get("Vdqss_Ref").Values.Time;

Sabc =  logsout.get("Sabc").Values.Data ;
ta =    logsout.get("Sabc").Values.Time;

Vdqss_Ref = interp1(tt, Vdqss_Ref, ta, 'previous');
Vdqss_Ref( isnan(Vdqss_Ref) ) = 0;

for ii=1:length(Sabc)
    Sabc(ii,1) = Sabc(ii,1)*4 + Sabc(ii,2)*2 + Sabc(ii,1);
end


vol = [0 0];

fig = figure;
ha = axes(fig);
hold(ha, 'on');
plot(ha, vol(2:end,1), vol(2:end,2), 'k-');
axis equal
pbaspect(ha, [1 1 1]);
% ha.Position = [  0.0777    0.5642    0.3540    0.3879];


for i=0:6
    vol(end+1, :) = Vdc*2/3 * [cos(i*pi/3) sin(i*pi/3)];
end
plot(ha, vol(2:end,1), vol(2:end,2), 'k-');

ps = [];
for i = 1:7
    ps(end+1) = plot(ha, vol(i,1), vol(i,2), 'ro', 'MarkerFaceColor','r');
end


end