function [p22] = plot_ax2_Vdqss(fig)
global Vd Vq;
ax2 = axes(fig);

li = zeros(7,2);
for i=1:7
    li(i,1) = 10 * cos(i*pi/3);
    li(i,2) = 10 * sin(i*pi/3);
end
plot(ax2, li(:,1), li(:,2), 'k-');

pbaspect(ax2, [1 1 1]); grid(ax2, 'on'); hold(ax2, 'on');
xlabel(ax2, 'V_d^e [10, 0]'); ylabel(ax2, 'V_q^e');

ax2.Position = [0.0462    0.0399    0.4055    0.4193]; % ax1.YStart + 0.5
% ax1.Position = [0.0462    0.5399    0.4055    0.4193];

p22 = plot(ax2, Vd, Vq, 'ro', 'MarkerSize', 8, 'markerfacecolor','r');

end

