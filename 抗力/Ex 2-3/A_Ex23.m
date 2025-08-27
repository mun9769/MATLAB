%% Initialization
clear;

% Run Simulink
[Mode, p, Lamf, Lds, Lqs, Rs, Is_Rated, Jm, Bm, Vdc, ...
fsw, Tsw, fs, Ts, Lamf_Hat, Rs_Hat, Lds_Hat, Lqs_Hat, ...
Jm_Hat, Bm_Hat, SpdObs, CC, Thetarm_Init, Wrm_Init, ...
Wrm_Fin, Idqsr_Ref_Set, Step_Time, Stop_Time] = f1_param();

[w_eqn, p_current, f1, t2] = f2_plot(Vdc, Lamf, Lds, Lqs, p, Is_Rated);

sim('Sim_Ex23.slx')


[Sabc, Vdqss_Ref, Vdqss, time_Sabc, time_Vdqss_Ref, Idqsr, Wr, time_Wr] = my_param(logsout);
% Sabc가 가변스텝이면 안되는거 아닌가
%%
syms w ids iqs
for i = 2400:length(Wr) 
    value = Wr(i); % Wr가 작아서 전압제한타원이 안보임
    aa = subs(w_eqn, w, value);
    f1.Function = subs(w_eqn, w, value);
    p_current.XData = Idqsr(i,1); p_current.YData = Idqsr(i,2);
    
    refreshdata(f1);
    drawnow;

    t2.String = ['$$' sprintf('w_{rpm} = %.0f', value * (60/2/pi) / p) '\ RPM' '$$'];
    pause(0); % todo: 시간간격을 맞춰야 보기 좋음.
    i
end


%%

% todo: q_Vdqss_ref_of 빼야
[fig, ha, ps, t_cnt, q_Vdqss_ref, q_Vdqss_ref_of, p_cur, p_avg, q_diff] = my_set_sixstep_fig(time_Sabc, Sabc,Vdc);

prv = 7;
st = 1;

% 사실
for ii=5:length(time_Vdqss_Ref)-1
    q_Vdqss_ref.Position = [0 0 Vdqss_Ref(ii,:)];
    q_Vdqss_ref_of.Position = [0 0 Vdqss_Ref_of(ii,:)];
    
    diff = Vdqss_Ref_of(ii,:) - Vdqss_Ref(ii,:);
    q_diff.Position = [Vdqss_Ref(ii,:) diff];

    cur = Sabc(ii,1); if cur == 0, cur = 7; end

    ps{prv}.MarkerFaceColor ='white';
    ps{cur}.MarkerFaceColor ='red';
    p_cur.XData = time_Sabc(ii); p_cur.YData = Sabc(ii,1);

    t_cnt.String = ['n: ' num2str(ii)];

    prv = cur;
    pause(0.1);
end
