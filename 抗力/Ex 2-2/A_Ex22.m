%% Initialization

clc
clear
close all
format short eng

% Simulation mode

Mode.PWM=2;         % PWM method
% 1: SCPWM, 2: 60deg DPWM, 3: 120deg(on) DPWM, 4: 120deg(off) DPWM

% RL load parameters

R=1;
L=1e-3;

% System parameters

Vdc = 250; % V_ref*sqrt(3)까지 ok

fsw=5e4;       % Switching frequency
Tsw=1/fsw;      % Switching period

fs=2*fsw;       % Samping frequency (double sampling)
Ts=1/fs;        % Samping period

% Command setting

Stop_Time=0.005;

V=Vdc/sqrt(3)*1.8;          % Amplitude of output voltage
W=2*pi*500;     % Angular speed of output voltage

% Run Simulink
out = sim('Sim_Ex22.slx');

[Sabc, Vdqss_Ref, Vdqss, ta, tt, Vdqss_Ref_of] = my_param(logsout);
[fig, ha, ps, t_cnt, q_Vdqss_ref, q_Vdqss_ref_of, p_cur, p_avg, q_diff] = my_set_sixstep_fig(ta, Sabc,Vdc);

prv = 7;
st = 1;

% 화살표는 mcu가 만드는 Vdqss_Ref.
% 빨간색 점은 mcu가 만드는 인버터 스위칭.
% 검은색 점은 인버터 스위칭이 만드는 실제 전압 (즉, 빨간점들의 평균)
% count는 몇번 스위칭 하는가 (??) 

for ii=5:length(tt)-1
    q_Vdqss_ref.Position = [0 0 Vdqss_Ref(ii,:)];
    q_Vdqss_ref_of.Position = [0 0 Vdqss_Ref_of(ii,:)];
    
    diff = Vdqss_Ref_of(ii,:) - Vdqss_Ref(ii,:);
    q_diff.Position = [Vdqss_Ref(ii,:) diff];

    cur = Sabc(ii,1);
    if cur == 0, cur = 7; end

    ps{prv}.MarkerFaceColor ='white';
    ps{cur}.MarkerFaceColor ='red';
    prv = cur;
    p_cur.XData = ta(ii); p_cur.YData = Sabc(ii,1);

    pause(0.0);

    % sum = sum + [ps{cur}.XData ps{cur}.YData];
    % t_cnt.String = ['count: ' num2str(jj-st+1)];

    pause(0.01);
end
