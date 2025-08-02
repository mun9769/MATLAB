%% Initialization

clc
clear
close all
format short eng
global Vdc;
% RL load parameters

R=1;
L=1e-3;

% System parameters

Vdc = 310;

fsw=10e3;       % Switching frequency
Tsw=1/fsw;      % Switching period

fs=2*fsw;       % Samping frequency (double sampling)
fs=20e3;       % Vdqs_Ref를 얼마나 자주 만드는가
Ts=1/fs;        % Samping period

% Command setting

Stop_Time=0.01;

V=310/2;          % Amplitude of output voltage
W=2*pi*800;          % Angular speed of output voltage


% Run Simulink

out=sim('Sim_Ex21.slx'); % varialbe step time으로 하면 시간이 등간격이 아님.

%%
[Sabc, Vdqss_Ref, Vdqss, ta, tt] = my_param(logsout);
[fig, ha, ps, t_cnt, q_Vdqss_ref, q_Vdqss, p_cur, p_avg] = my_set_sixstep_fig(ta, Sabc);
prv = 7;
st = 1;

% 화살표는 mcu가 만드는 Vdqss_Ref.
% 빨간색 점은 mcu가 만드는 인버터 스위칭.
% 검은색 점은 인버터 스위칭이 만드는 실제 전압 (즉, 빨간점들의 평균)
% count는 몇번 스위칭 하는가

% todo: fsw는 10kHz, 일정 주기로 시뮬레이션

for ii=5:length(tt)-1
     
    q_Vdqss_ref.UData = Vdqss_Ref(ii,1);
    q_Vdqss_ref.VData = Vdqss_Ref(ii,2);

    [~, en] = min(abs(ta - tt(ii+1)));
    
    sum = [0 0];
    for jj=st:en
        cur = Sabc(jj,1);
        if cur == 0, cur = 7; end
        sum = sum+[ps{cur}.XData ps{cur}.YData];
    end
    sum = sum / (en - st + 1);

    p_avg.XData = sum(1);
    p_avg.YData = sum(2);


    for jj=st:en
        cur = Sabc(jj,1);
        if cur == 0, cur = 7; end
        
        ps{prv}.MarkerFaceColor ='white';
        ps{cur}.MarkerFaceColor ='red';
        prv = cur;
        p_cur.XData = ta(jj); p_cur.YData = Sabc(jj,1);
        
        q_Vdqss.UData = Vdqss(jj,1);
        q_Vdqss.VData = Vdqss(jj,2);
        pause(0.12);

        sum = sum + [ps{cur}.XData ps{cur}.YData];
        t_cnt.String = ['count: ' num2str(jj-st+1)];
    end


    st = en;
    pause(0.2);
end
