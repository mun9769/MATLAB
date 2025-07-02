% todo: 정격전류의 1.8배에 대해서 최대 범위 정하기.
% todo: MTPA 곡선 그리기


close all;
syms ids iqs Te P phi Lds Lqs

P = 8;
eqn = Te == 3/2*P * (ids*iqs*(Lds - Lqs) + phi*iqs);

eqn_subs = subs(eqn, [phi,   Lds   Lqs], ...
                      [1, 30e-3 40e-3]);


Te_func = matlabFunction(rhs(eqn_subs), 'Vars', [ids, iqs]);

% 축 범위 설정 및 그리드 생성
ids_range = linspace(-100, 50, 100); 
iqs_range = linspace(-75, 75, 100);  
% ids_range = linspace(-20, 0, 100); 
% iqs_range = linspace(0, 20, 100);  
[IDS, IQS] = meshgrid(ids_range, iqs_range);


% 토크 값 계산
TE = Te_func(IDS, IQS);

% 등고선 플롯 생성
figure; hold on; grid on; axis equal
[C,h]=contourf(IDS, IQS, TE, 12, 'LineWidth', 1.5);
clabel(C,h,'labelspacing', 1e20)
plot([-100 50], [0 0], 'k', linewidth=0.6)
plot([0 0], [-75 75], 'k', linewidth=0.6)

% colorbar;
title('Torque Contour Plot (Te = 3/2*P*(ids*iqs*(Lds-Lqs) + \phi*iqs))');
xlabel('ids (A)');
ylabel('iqs (A)');
% colormap jet;
% grid on;

