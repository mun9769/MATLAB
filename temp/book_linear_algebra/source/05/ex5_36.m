format rat
x1=[1 0 0]';x2=[1 1 0]';x3=[1 1 1]';                % 벡터 입력
y1=1/norm(x1)*x1                                    % 1단계 결과
z2=x2-dot(x2,y1)*y1;y2=1/norm(z2)*z2                % 2단계 결과
z3=x3-dot(x3,y1)*y1-dot(x3,y2)*y2;y3=1/norm(z3)*z3  % 3단계 결과