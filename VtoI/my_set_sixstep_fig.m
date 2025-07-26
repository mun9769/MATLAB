
function [fig, ha, hb] = my_set_sixstep_fig()
global Vdc P Lds Lqs Lamf to_rps to_rpm w

Ls = [Lds 0; 0 Lqs];
J = [0 -1; 1 0];

vol = [0 0];
v_lim = zeros(8,2);

fig = figure;
ha = axes(fig);
plot(ha, vol(2:end,1), vol(2:end,2), 'k-');
pbaspect(ha, [1 1 1]);
ha.Position = [  0.0777    0.5642    0.3540    0.3879];

hb = axes(fig);
pbaspect(hb, [1 1 1]);
hb.Position = [  0.5337    0.5622    0.3625    0.3972];


for i=0:6
    vol(end+1, :) = Vdc*2/3 * [cos(i*pi/3) sin(i*pi/3)];
end
plot(ha, vol(2:end,1), vol(2:end,2), 'k-');

for i = 1:7
    text(ha, vol(i,1), vol(i,2), ...
         sprintf('%d', i-1), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 12, 'FontWeight', 'bold', ...
        'Color', 'red');
end


for i=1:8
    v_lim(i,:) = 1/w*inv(J)* vol(i,:)';
    v_lim(i,:) = v_lim(i,:) - [Lamf 0];
    v_lim(i,:) = inv(Ls) * v_lim(i,:)';
end




plot(hb, v_lim(2:end,1), v_lim(2:end,2), 'k-');

for i = 1:7
    text(hb, v_lim(i,1), v_lim(i,2), sprintf('%d', i-1), ...
        'HorizontalAlignment', 'center', ...
        'VerticalAlignment', 'middle', ...
        'FontSize', 12, 'FontWeight', 'bold', ...
        'Color', 'b');
end

axis(hb, [-10 2 -6 6]*1.5);

end