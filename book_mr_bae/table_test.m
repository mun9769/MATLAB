clear; close all; clc;
[fig, t1, f1] = my_set_fig();

syms iqs ids w;
syms Te;

my_set_sim_param();
w_eqn = (Vsmax/w)^2 == (Lamf+Lds*ids)^2 + (Lqs*iqs)^2; 


out = sim('table_test.slx');
Idsr =      squeeze (out.logsout.get("Idsr").Values.Data );
Iqsr =      squeeze( out.logsout.get("Iqsr").Values.Data );
Idsr_Ref =  squeeze( out.logsout.get("Idsr_Ref").Values.Data);
Iqsr_Ref =  squeeze( out.logsout.get("Iqsr_Ref").Values.Data);
Wr =        squeeze( out.logsout.get("Wr").Values.Data) ;

assert(length(Idsr) == length(out.tout), 'length not validation');
assert(length(Iqsr) == length(out.tout), 'length not validation');
assert(length(Wr)   == length(out.tout), 'length not validation');

hold on;
p2 = plot(0, 0, 'mo', 'MarkerFaceColor', 'm');

for ii=10:10:length(out.tout)
    p2.XData = Idsr(ii); p2.YData = Iqsr(ii);
    
    pause(0);
    
    if Wr(ii) ~= 0
    f1.Function = subs(w_eqn, w, Wr(ii));
    refreshdata(f1);
    end

% f1= fimplicit(subs(w_eqn, w, wr_val), 'k--');
    if mod(ii, 1000) == 0
        t1.String = [num2str(ii/100000) 's'];
    end
    
end

