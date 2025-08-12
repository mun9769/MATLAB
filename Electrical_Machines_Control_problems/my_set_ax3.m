function [p1, p2, p3] = my_set_ax3(fig)


ax3_1 = axes(fig);
ax3_1.Position = [0.4409+0.25    0.7719    0.2572    0.1855];
ax3_2 = axes(fig);
ax3_2.Position = [0.4409+0.25    0.4719    0.2572    0.1855];
ax3_3 = axes(fig);
ax3_3.Position = [0.4409+0.25    0.1719    0.2572    0.1855];


xlim = 4*pi; ylim = 10;
title(ax3_1, 'V_a');
title(ax3_2, 'V_b');
title(ax3_3, 'V_c');

hold(ax3_1, 'on');
hold(ax3_2, 'on');
hold(ax3_3, 'on');

xticks(ax3_1, [2*pi, 4*pi, 6*pi, 8*pi]);
xticklabels(ax3_1, {'2\pi', '4\pi', '6\pi', '8\pi'});
xticks(ax3_2, [2*pi, 4*pi, 6*pi, 8*pi]);
xticklabels(ax3_2, {'2\pi', '4\pi', '6\pi', '8\pi'});
xticks(ax3_3, [2*pi, 4*pi, 6*pi, 8*pi]);
xticklabels(ax3_3, {'2\pi', '4\pi', '6\pi', '8\pi'});

axis(ax3_1, [0 xlim -ylim ylim])
axis(ax3_2, [0 xlim -ylim ylim])
axis(ax3_3, [0 xlim -ylim ylim])


p1 = plot(ax3_1, 0, 0, 'color', 'r');
p2 = plot(ax3_2, 0, 0, 'color', 'b');
p3 = plot(ax3_3, 0, 0, 'color', 'g');

end