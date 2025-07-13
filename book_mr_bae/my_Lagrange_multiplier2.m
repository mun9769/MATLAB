function [x_mn, y_mn, w] = my_Lagrange_multiplier2(f, g, x, y, w)
syms lambda

Lagr = g - lambda * f;
eqns = [diff(Lagr,x) ==0, diff(Lagr, y) == 0, diff(Lagr, w) == 0, g];
sol = solve(eqns, [x, y, w, lambda], 'real', true);
tmp = fieldnames(sol);

x_mn = vpa(sol.(tmp{1}));
y_mn = vpa(sol.(tmp{2}));
w = vpa(sol.(tmp{3}));

x_mn = double( x_mn(1) );
y_mn = double( y_mn(1) );
w    = double( w(1) ); % 1번째 인자가 최소인지는 검토해야할것.

end
