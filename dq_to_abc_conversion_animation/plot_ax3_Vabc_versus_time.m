function [p1, p2, p3] = plot_ax3_Vabc_versus_time(fig, xlim)

ax3_1 = axes(fig);
ax3_1.Position = [0.4409    0.7719    0.5072    0.1855];
ax3_2 = axes(fig);
ax3_2.Position = [0.4409    0.4719    0.5072    0.1855];
ax3_3 = axes(fig);
ax3_3.Position = [0.4409    0.1719    0.5072    0.1855];


ylim = 10;
title(ax3_1, 'V_a');
title(ax3_2, 'V_b');
title(ax3_3, 'V_c');

hold(ax3_1, 'on');
hold(ax3_2, 'on');
hold(ax3_3, 'on');

axis(ax3_1, [0 xlim -ylim ylim])
axis(ax3_2, [0 xlim -ylim ylim])
axis(ax3_3, [0 xlim -ylim ylim])


p1 = plot(ax3_1, 0, 0, 'color', 'r');
p2 = plot(ax3_2, 0, 0, 'color', 'b');
p3 = plot(ax3_3, 0, 0, 'color', 'g');

end