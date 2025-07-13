% 예시: 원의 방정식 x² + y² - 4 = 0 (반지름 2)
f = @(x, y) x.^2 + y.^2 - 4;

% 최적화 문제 설정
objective = @(p) (p(1) - 1)^2 + (p(2) - 3)^2;  % (x-1)² + (y-3)²
nonlcon = @(p) deal(f(p(1), p(2)), []);  % 비선형 제약 조건 (f(x,y) = 0)

% 초기 추정값 (예: 원점)
p0 = [0, 0];

% 최적화 실행
options = optimoptions('fmincon', 'Display', 'off');
p_opt = fmincon(@(p) (p(1) - 1)^2 + (p(2) - 3)^2, ...
                p0, [], [], [], [], [], [], nonlcon, options);

% 결과 출력
fprintf('가장 가까운 점: (%.4f, %.4f)\n', p_opt(1), p_opt(2));
fprintf('최소 거리: %.4f\n', norm(p_opt - [1, 3]));

% 시각화
ezplot('x^2 + y^2 - 4', [-3, 3, -3, 3]); hold on;
plot(1, 3, 'ro', 'MarkerSize', 10);
plot(p_opt(1), p_opt(2), 'go', 'MarkerSize', 10);
axis equal; grid on;
legend('곡선 f(x,y)=0', '(1, 3)', '가장 가까운 점');

%%
% clear all; clc;
% 
% function f = objective(x, H)
%     f=x(1)*x(2)*H; %x(1) = L, x(2) = W, H is given
% end
% 
% function [c, ceq] = constaratints(x, H, P) 
% % c는 0보다 작거나 같다.
% % ceq는 0과 같다.
%     c(1) = x(2)-0.1*x(1); % W <= 0.1L
%     c(2) = 6*P*x(1)-3500*x(2)*H^2;
%     ceq=[];
% end
% 
% LB= [4 0]; % lb for [L W]
% UB=[36 6]; % ub for [L W]
% P=200; % load
% H = 2; % height
% x0=[12 1.2]; % initial guess for the design variables [ L, W]
% Aeq=[]; % linear equality constaraint matrix
% Beq=[]; % linear equality constraint RHS
% 
% 
% % fmincon(fun,x0,A,b,Aeq,beq,lb,ub,nonlcon,options)
% 
% % optimization option
% tol = 1e-6;
% options = optimset('display','iter','plotFcns','optimplotfval', ...
%                    'TolX', tol, 'TolFun',tol, 'TolCon', tol, 'algorithm', 'sqp');
% 
% % alternative algorithms
% % active-set/trust-region-reflective/interior-point/sqp
% 
% [x,fval,exitflag,output] = fmincon(@(x) objective(x,H), x0, [],[], [],[], ...
%                                     LB, UB, @(x) constaratints(x,H,P), options)
% % exitflag 1: 최적화가 잘됨
% 
% 
% 
% 
% 
% 
% 
% 
