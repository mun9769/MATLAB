function [a] = my_set_ax1(fig)
a=-1;
global Vd Vq;
ax1 = axes(fig);

li = zeros(7,2);
for i=1:7
    li(i,1) = 10 * cos(i*pi/3);
    li(i,2) = 10 * sin(i*pi/3);
end
plot(ax1, li(:,1), li(:,2), 'k-');

pbaspect(ax1, [1 1 1]); grid(ax1, 'on'); hold(ax1, 'on');
xlabel(ax1, sprintf('V_d^r [%.1f %.1f]', Vd, Vq)); 
ylabel(ax1, 'V_q^r');
ax1.Position = [0.0462    0.5399    0.4055    0.4193];

t1 = title(ax1, '마우스로 좌표 클릭');
p1 = plot(ax1, Vd, Vq, 'ro', 'MarkerSize', 8);



% 마우스 클릭 이벤트 설정
set(ax1, 'ButtonDownFcn', @(src,event) onClick(ax1, p1));
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

