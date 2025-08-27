function [x_mn, y_mn] = my_Lagrange_multiplier2(f, g, x, y)
syms lambda

Lagr = f - lambda * g;
eqns = [diff(Lagr,x) ==0, diff(Lagr, y) == 0, g==0];
sol = solve(eqns, [x, y, lambda]); %, 'real', true); % real 붙이면 너무 느려지네
tmp = fieldnames(sol);


x_mn = double(sol.(tmp{1}));
y_mn = double(sol.(tmp{2}));

idx = x_mn < 0;
if any(idx)
    first_idx = find(idx, 1);
    x_mn = x_mn(first_idx);
    y_mn = y_mn(first_idx);
else
    x_mn = NaN; % or handle the case where no valid index is found
    y_mn = NaN; % or handle the case where no valid index is found
end

end
