function f = abc2dqw(theta, T)
assert(isequal(size(T), [3, 3]), 'T는 3x3 행렬이어야');

z = { zeros(size(theta)) };
o = { ones(size(theta)) };

R = [{cos(theta)} {-sin(theta)} z; {sin(theta)} {cos(theta)} z; z z o];

f{1,1} = R{1,1} .* T(1,1) + R{1,2} .* T(2,1);
f{1,2} = R{1,1} .* T(1,2) + R{1,2} .* T(2,2);
f{1,3} = R{1,1} .* T(1,3) + R{1,2} .* T(2,3);

f{2,1} = R{2,1} .* T(1,1) + R{2,2} .* T(2,1);
f{2,2} = R{2,1} .* T(1,2) + R{2,2} .* T(2,2);
f{2,3} = R{2,1} .* T(1,3) + R{2,2} .* T(2,3);


f{3,1} = R{3,3} .* T(3,1);
f{3,2} = R{3,3} .* T(3,2);
f{3,3} = R{3,3} .* T(3,3);

end