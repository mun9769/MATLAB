function xy = my_eqn_to_xy(F, x_range)
syms ids iqs
xy=[]

y_eqn = solve(F, iqs);

x_val = linspace(x_range(1), x_range(2), 400);
y_val = subs(y_eqn, x_val);
y_val = double(y_val);

for i=1:size(y_val,1)
    xy = [xy, [x_val; y_val(i,:)]]; 
end

xy = xy';

end
