%% Initialization

% Run Simulink
[Mode, p, Lamf, Lds, Lqs, Rs, Is_Rated, Jm, Bm, Vdc, fsw, Tsw, fs, Ts, ...
    Lamf_Hat, Rs_Hat, Lds_Hat, Lqs_Hat, Jm_Hat, Bm_Hat, ...
    MTPA, SpdObs, CC, Thetarm_Init, Wrm_Init, Wrm_Fin, Te_Ref_Set, ...
    Te_SlewRate, Step_Time, Stop_Time] = f1_param();

[w_eqn, p_current, f1, t2] = f2_plot(Vdc, Lamf, Lds, Lqs, p, Is_Rated, MTPA);


sim('Sim_Ex24.slx')

[Sabc, Vdqss_Ref, Vdqss, Idqsr, Wr, ...
    time_Wr, time_Sabc, time_Vdqss_Ref ] = f3_sim_sig(logsout);

%%
syms w ids iqs
for i = 8000:length(Wr) 
    value = Wr(i); % Wr가 작아서 전압제한타원이 안보임
    f1.Function = subs(w_eqn, w, value);
    p_current.XData = Idqsr(i,1); p_current.YData = Idqsr(i,2);
    
    refreshdata(f1);
    drawnow;

    t2.String = ['$$' sprintf('w_{rpm} = %.0f', value * (60/2/pi) / p) '\ RPM' '$$'];
    pause(0); % todo: 시간간격을 맞춰야 보기 좋음.
    i
end

