function [x_mn, y_mn, dist] = my_Lagrange_multiplier(f, x, y)
syms lambda

Lagr = x^2 + y^2 - lambda * f;
eqns = [diff(Lagr,x) ==0, diff(Lagr, y) == 0, f];
sol = solve(eqns, [x, y, lambda]);
tmp = fieldnames(sol);

x_mn = vpa(sol.(tmp{1}));
y_mn = vpa(sol.(tmp{2}));

x_mn = double( x_mn(1) );
y_mn = double( y_mn(1) ); % 1번째 인자가 최소인지는 검토해야할것.

dist = sqrt(x_mn^2 + y_mn^2);

end
