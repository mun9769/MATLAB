function f = s2e(theta, fdqs)

fdse =  cos(theta) .* fdqs(1,:) + sin(theta) .* fdqs(2,:);
fqse = -sin(theta) .* fdqs(1,:) + cos(theta) .* fdqs(2,:);

f = [fdse; fqse;];

end