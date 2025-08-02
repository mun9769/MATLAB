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

fsw=4000;       % Switching frequency
Tsw=1/fsw;      % Switching period

fs=2*fsw;       % Samping frequency (double sampling)
fs=10000;       % Vdqs_Ref를 얼마나 자주 만드는가
Ts=1/fs;        % Samping period

% Command setting

Stop_Time=0.01;

V=310/1.6;          % Amplitude of output voltage
W=2*pi*500;          % Angular speed of output voltage


% Run Simulink

out=sim('Sim_Ex21.slx');

%%
[Sabc, Vdqss_Ref, Vdqss, ta, tt] = my_param(logsout);
[fig, ha, ps, text, q_Vdqss_ref, q_Vdqss, pcur] = my_set_sixstep_fig(ta, Sabc);

%
prv = 7;
st = 1;
for ii=1:length(tt)-1
    % 
    % q_Vdqss_ref.UData = Vdqss_Ref(ii,1);
    % q_Vdqss_ref.VData = Vdqss_Ref(ii,2);


    [~, en] = min(abs(ta - tt(ii+1)));

    for jj=st:en
        cur = Sabc(jj,1);
        if cur == 0, cur = 7; end
        
        ps{prv}.MarkerFaceColor ='white';
        ps{cur}.MarkerFaceColor ='red';
        prv = cur;

        pcur.XData = ta(jj); pcur.YData = Sabc(jj,1);

    q_Vdqss.UData = Vdqss(jj,1);
    q_Vdqss.VData = Vdqss(jj,2);
        pause(0.1);
    end

    text.String = [num2str(ii/10) 'ms'];
    st = en;
    pause(0.5);
end
