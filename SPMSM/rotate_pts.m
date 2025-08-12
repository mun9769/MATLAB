function [x1, y1] = rotate_pts(x, y, t)
    
rot = [cos(t) -sin(t); sin(t) cos(t)];
uu = rot * [x; y];
x1 = uu(1,:);
y1 = uu(2,:);
end