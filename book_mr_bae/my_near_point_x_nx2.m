function x = my_near_point_x_nx2(fxy, p0)
% p0 = [1 2]
% f = 2xn

diff = fxy - p0;
norms = vecnorm(diff, 1, 2);  % Compute L2 norm along each column (result: 1×100)
[~,idx] = min(norms);

x=fxy(idx,1);

end