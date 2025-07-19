function idx = my_nearest_index_2xn(fxy, p0)
% p0 = [1 2]
% f = 2xn

diff = fxy - p0;
norms = vecnorm(diff, 2, 1);  % Compute L2 norm along each column (result: 1×100)
[~,idx] = min(norms);

end