clear all;
close all;
clc;

% Simulation Parameters
Stop_Time=5; %%%%%%%%%%%%%%%%%%%%
% Motor Mecharnical Parameters


J= 0.001; %0.1 kgm^2
B= 0.001; %Nms


% Stop_Time=0.15; %%%%%%%%%%%%%%%%%%%%
% Time_Ref=   [0.01    2       2.01    3       3.01 4 4.01 5];
% TL=         [0       0       8       8       -4  -4 8 8];
% Wrpm_Ref =  [2900    2900    3000    3000    3000 0 0 0];

Time_Ref=   [0 0.1  0.11    1       1.01    2       2.01    3       3.01 4 4.01 5];
TL=         [0 0    0       0       0       0       8       8       -4  -4 8 8];
Wrpm_Ref =  [0 0    100     100     2900    2900    3000    3000    3000 0 0 0];

% Motor Electrical Parameters
Po_rated = 3000; %kw
Va_rated = 100; %V
Ia_rated=20; %A

Wrpm_rated=3000;

Wrm_rated=Wrpm_rated/60*2*pi;

Ra=0.3; %Ohm
La=10.0e-3; %H

Lf=0.4775; %H
If_rated=1; %A

Te_rated=Po_rated/Wrm_rated;

Kt= Te_rated/Ia_rated;
Ke=Kt;
% Inverter
Fsw=1e3;
Vdc=160;

%% control parameter
Fcc = Fsw / 10;

Wcc = 2*pi*Fcc;
Kpc = La*Wcc;
Kic = Ra*Wcc;
Kac = 0/Kpc;

Fsc = Fcc / 2.2; % 수정: Fsc = Fcc / 5

Wsc = 2*pi*Fsc;
Kps = J*Wsc/Kt + 11.3; % 수정: 10추가하니 3e-3 줄어듬.
Kis = J*Wsc^2/5/Kt - 10;
Kas = 0.0/Kps;
Param = struct('Fcc', Fcc, 'Wcc', Wcc, 'Kpc', Kpc, 'Kic', Kic, ...
               'Fsc', Fsc, 'Wsc', Wsc, 'Kps', Kps, 'Kis', Kis);

num = 1000*[J B+Kt*Kps Kt*Kis];
den = Kt*poly([-10, -1e6]);
%%
close all;
figure;
stem(out.tout, wrpm_term);
xlim([1 1.05])
figure
plot(out.tout, relu_term);
%%
close all;
Stop_Time = 5;
out = sim('Sim_Dist_Prot__');

plot(out.tout, out.Wrm);
hold on;
plot(out.tout, out.Wrm_Ref);

wrpm_term = out.tout.*((out.Wrm_Ref-out.Wrm).^2);
relu_term = out.tout.*max(0, abs(out.Ia) - 20).^2;

integral1 = trapz(out.tout, (out.Wrm_Ref-out.Wrm).^2) / (5 * Wrm_rated^2);
integral2 = trapz(out.tout, max(0, abs(out.Ia) - 20).^2) / (5 * Ia_rated^2);
res = integral1 + integral2;

fprintf('최종 결과 res: %.9f\n', res);
fprintf('속도 추정초과치: %.9f\n', integral1);
fprintf('전류 초과치:    %.9f\n', integral2);

% while 

%% Current Control 이 아래에 게인을 설정해서 쓰세요

H = zpk([-1],[-10 -100],100);
% margin(H);
%20logH(0)를 구하라.

%%

Stop_Time = 1.1
[x, y] = ndgrid(-0.1:0.1:0.1, -0.1:0.1:0.1);
d = [x(:), y(:)];
answer = 1e3;
while true
    ni = -1;
    pki = Kis;
    pkp = Kps;
    pws = Wsc;
    pwc = Wcc;
    for i = 1:length(d)
        tic;
        Kis = pki + d(i, 1);
        Kps = pkp + d(i, 2);

        out = sim('Sim_Dist_Prot__');
        close all;

        integral1 = trapz(out.tout, (out.Wrm_Ref-out.Wrm).^2) / (5 * Wrm_rated^2);
        relu_term = max(0, abs(out.Ia) - 20).^2;
        integral2 = trapz(out.tout, relu_term) / (5 * Ia_rated^2);
        err = integral1 + integral2;
        fprintf('결과 answer: %.9f\n', err);    
    fprintf('속도 추정초과치: %.9f\n', integral1);
    fprintf('전류 초과치:    %.9f\n', integral2);

        if(answer > err)
            answer = err;
            ni = i;
        end
        
        plot(out.tout, out.Wrm);
        hold on;
        plot(out.tout, out.Wrm_Ref);

        elapsedTime = toc;  % 경과 시간 저장 및 출력
        fprintf('Elapsed time: %.4f seconds\n', elapsedTime);
    end

    if ni == -1
        break
    end

    fprintf('Ki: %.9f\n', Kis);
    fprintf('Kp: %.9f\n', Kps);
    % fprintf('Ws: %.9f\n', Wsc);
    % fprintf('Wc: %.9f\n\n', Wcc);

    fprintf('결과 answer: %.9f\n', answer);
    fprintf('속도 추정초과치: %.9f\n', integral1);
    fprintf('전류 초과치:    %.9f\n', integral2);
    fprintf('----------------------------------------------\n');
    
end
