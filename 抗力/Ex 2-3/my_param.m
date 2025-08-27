function [Sabc, Vdqss_Ref, Vdqss, time_Sabc, time_Vdqss_Ref, Idqsr, Wr, time_Wr] = my_param(logsout)

Vdqss_Ref =  logsout.get("Vdqss_Ref").Values.Data;
Idqsr =  logsout.get("Idqsr").Values.Data;
Wr =  logsout.get("Wr").Values.Data;


Vdqss     =  logsout.get("Vdqss").Values.Data;
Sabc =  logsout.get("Sabc").Values.Data;


time_Vdqss_Ref = logsout.get("Vdqss_Ref").Values.Time;
time_Sabc =    logsout.get("Sabc").Values.Time;
time_Wr =    logsout.get("Wr").Values.Time;
time_Idqsr = logsout.get("Idqsr").Values.Time;


tol = 1e-6; % 허용 오차
is_equal = all(abs(time_Idqsr - time_Wr) < tol);

if ~is_equal
    fprintf("두 신호의 시간은 같지가 않습니다") % 시뮬링크에서 같은 블록에 위치해서 아마 같을거야.
else
    fprintf("두 신호의 시간 같아")
end

% Vdqss_Ref_of =  logsout.get("Vdqss_Ref_overflow").Values.Data;
% time_Vdqss_Ref_of = logsout.get("Vdqss_Ref_overflow").Values.Time;
% Vdqss_Ref_of = interp1(time_Vdqss_Ref_of, Vdqss_Ref_of, time_Vdqss_Ref, 'previous');
% Vdqss_Ref_of( isnan(Vdqss_Ref_of) ) = 0;

for ii=1:length(Sabc)
    Sabc(ii,1) =  Sabc(ii,3)*4 + Sabc(ii,2)*2 + Sabc(ii,1);
end

end