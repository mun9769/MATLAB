%% A == V*D*inv(V)
clear; close all;
A = [2 -2;
    -2 5];
[V, D] = eig(A);

figure;
hold on; grid on;
axis([-5 5 -5 5]);
pbaspect([1 1 1]);

% Plot the eigenvectors
quiver(0, 0, V(1,1), V(2,1), 'k', 'LineWidth', 2);
quiver(0, 0, V(1,2), V(2,2), 'k', 'LineWidth', 2);

p = [linspace(0,2, 50);
    linspace(0,2, 50)];
q = A*p;
qq = (V*D*inv(V)) *p;

plot(p(1,:), p(1,:), 'r-');
plot(q(1,:), q(2,:), 'b-');
plot(qq(1,:), qq(2,:), 'g--');
%%
% eigen vector의 크기는 항상 1? >> yes
% eigen vector가 열인 행렬은 항상 회전행렬? >> no, eigen vector들의 내적이 0이 아님.

clear; close all;
A = [1 2 3;
     4 5 6;
     7 8 9;]; % V'*V != eye, det(V)=-0.96
A = [18 4;
     2 12];
A = [1 2;
    3 4;]; % V'*V != eye, det(V)=0.98
[V, D] = eig(A);
figure;
hold on; grid on;
axis([-3 3 -3 3]);
pbaspect([ 1 1 1]);

quiver(0, 0,V(1,1),V(2,1), 'r-');
quiver(0, 0,V(1,2),V(2,2), 'r-');

fprintf('-----------------------\n');
fprintf('V:\n');
disp(V);
fprintf('D:\n');
disp(D);
fprintf('V'' * V:\n');
disp(V' * V);
fprintf('Determinant of V: %f\n', det(V));

% Calculate the dot product of the first two eigenvectors
dot_product = dot(V(:,1), V(:,2));
fprintf('Dot product of V(:,1) and V(:,2): %f\n', dot_product);


%% 만약 eigen value가 허수라면?

%% 대각화 가능한가? 중근에 대해서
clear; close all;
A = [2 1 0;
     0 2 0;
     2 3 1;]; % >> (중근)3차원행렬인데, 대각화 불가능. 
% >> eigen vector 두개가 dependency하다.
% >> 대각화한 연산이 안된다 즉, A != VDV'

A = [0 0 -2;
     1 2  1;
     1 0  3;]; % >> (중근)3차원행렬인데, 대각화 가능.

A = [4 -2 2;
    -2  4 2;
     2  2 4;];
[V, D] = eig(A);

figure;
hold on; grid on;
axis([-3 3 -3 3 -3 3]);
pbaspect([1 1 1]);

% Plot the 3D quiver
ref=...
quiver3(0,0,0, V(1,1), V(2,1), V(3,1), 'r', linewidth=2, displayname='reference');
quiver3(0,0,0, V(1,2), V(2,2), V(3,2), 'r', linewidth=2);
quiver3(0,0,0, V(1,3), V(2,3), V(3,3), 'r', linewidth=2);


p = [linspace(0,2, 50);
     linspace(0,2, 50);
     linspace(0,2, 50);];
q = A*p;
r = (V*D*inv(V))*p;


pp=plot3(p(1,:), p(2,:), p(3,:), 'k-', displayname='정의역');
qq=plot3(q(1,:), q(2,:), q(3,:), 'b-', displayname='치역');
rr=plot3(r(1,:), r(2,:), r(3,:), 'g--', displayname="대각화한 치역");

legend([ref pp qq rr]);
xlabel('X-axis');
ylabel('Y-axis');
zlabel('Z-axis');
title('3D Quiver Plot');
view(3); % Set the view to 3D


fprintf('V:\n');
disp(V)
V(:,1)' * V(:,3); % 고유값이 다른 두 eigen vector의 곱은 0;

%% 연립 미분방정식
clear; close all;

syms x(t) y(t)
u = dsolve( ...
    diff(x)==7*x-10*y, ...
    diff(y)==3*x-4*y, ...
    x(0)==1, y(0)==0);

sol=[u.x; u.y]

%%
clear
imshow(imread('test.png'));
title('test');

figure
