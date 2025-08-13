function [p11, ax1] = plot_ax1_Vdqse(fig)
global Vd Vq;
ax1 = axes(fig);


tmp = linspace(0,2*pi,50);
Vs = 15/sqrt(3);

plot(Vs*cos(tmp), Vs*sin(tmp), 'k-');


pbaspect(ax1, [1 1 1]); grid(ax1, 'on'); hold(ax1, 'on');
xlabel(ax1, sprintf('V_d^r [%.1f %.1f]', Vd, Vq)); 
ylabel(ax1, 'V_q^r');
ax1.Position = [0.0462    0.5399    0.4055    0.4193];
t1 = title(ax1, '마우스로 좌표 클릭');
p11 = plot(ax1, Vd, Vq, 'ro', 'MarkerSize', 8, 'markerfacecolor','r');


% 마우스 클릭 이벤트 설정
set(ax1, 'ButtonDownFcn', @(src,event) onClick(ax1, p11));
end


function onClick(ax1, p1)
    global Vd Vq
    pt = get(ax1, 'CurrentPoint');
    Vd = pt(1,1);
    Vq = pt(1,2);
    
    % 첫 번째 서브플롯에 점 표시
    set(p1, 'XData', Vd, 'YData', Vq);

    % 두 번째 서브플롯에 좌표 업데이트
    new_text = sprintf(' [%.1f, %.1f]', Vd, Vq);
    ax1.XLabel.String = ['V_d^r' new_text];

end

