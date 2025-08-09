function [x3, y3] = getLineLineIntersection(p1, u1, p2, u2)

x1 = p1(1); y1 = p1(2);
x2 = p2(1); y2 = p2(2);
u1 = u1(2)/u1(1);
u2 = u2(2)/u2(1);


A = [u1 -1; 
     u2 -1];

b = [u1*x1 - y1; 
     u2*x2 - y2];
ret = inv(A) * b;

x3 = ret(1);
y3 = ret(2);
end