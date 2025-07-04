function idx = my_nearest_index(f1, x, y)

dist_mn = inf;

for i=1:size(f1.XData,2)
    dist = norm([f1.XData(i) f1.YData(i)] - [x y]);
    if(dist_mn > dist)
        dist_mn = dist;
        idx = i;
    end
end

end