function idx = my_nearest_index_2xn_2xm(fxy, gxy)
% f = 2xn
% g = 2xm
mn = inf;
idx = -1;

for i=1:size(gxy,2)
    gx = gxy(1,i);
    gy = gxy(2,i);
    for j=1:size(fxy, 2)
        fx = fxy(1,i);
        fy = fxy(2,j);
        dist = norm([gx gy] - [fx fy]);
        if dist < mn
            mn = dist;
            idx = j;
        end
    end
end


end