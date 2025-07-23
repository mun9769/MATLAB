% 3INV_6pulse_RL_SPWM
clear; close all; 
Simulink.sdi.close;

Vdc=100;
fsw = 50;
Stop_time = 1/fsw * 2;
Rs = 10;
Ls = 1e-2;
step_time = 1/fsw/3;
R_FET = 0;
R_Diode = 0;


out = sim('three_phase_inverter.slx');
time_eq = out.tout == out.logsout.get("Vbn").Values.Time;
if any(time_eq == 0)
    error('시뮬타임과 데이터타임이 일치하지 않습니다.');
end

out.logsout.plot


% Vab = out.logsout.get("Vab");
% Van = out.logsout.get("Van");
% Vbn = out.logsout.get("Vbn");
% Vcn = out.logsout.get("Vcn");
% Vsn = out.logsout.get("Vsn");
% Ias = out.logsout.get("Ias");
% 
% figure;
% aa = 411;
% subplot 411
% plot(out.tout, out.logsout.get("Van").Values.Data, 'r')
% axis([0 Stop_time -120 120])
% 
% subplot 412
% plot(out.tout, out.logsout.get("Vbn").Values.Data, 'g')
% axis([0 Stop_time -120 120])
% 
% subplot 413
% y = out.logsout.get("Vsn");
% plot(out.tout, out.logsout.get("Vsn").Values.Data, 'k')
% axis([0 Stop_time -120 120])
% 
% subplot 414
% plot(out.tout, out.logsout.get("Vab").Values.Data, 'k')
% ylabel(Vab.Name);
% 
% subplot 414
% plot(out.tout, Ias.Values.Data, 'k')
% ylabel(Ias.Name);
% 
% 
