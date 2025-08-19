function [Sabc, Vdqss_Ref, Vdqss, time_Sabc, time_Vdqss_Ref, Vdqss_Ref_of] = my_param(logsout)

Vdqss_Ref =  logsout.get("Vdqss_Ref").Values.Data;
Vdqss_Ref_of =  logsout.get("Vdqss_Ref_overflow").Values.Data;


Vdqss     =  logsout.get("Vdqss").Values.Data;
Sabc =  logsout.get("Sabc").Values.Data ;


time_Vdqss_Ref = logsout.get("Vdqss_Ref").Values.Time;
time_Sabc =    logsout.get("Sabc").Values.Time;
time_Vdqss_Ref_of = logsout.get("Vdqss_Ref_overflow").Values.Time;

Vdqss_Ref_of = interp1(time_Vdqss_Ref_of, Vdqss_Ref_of, time_Vdqss_Ref, 'previous');
Vdqss_Ref_of( isnan(Vdqss_Ref_of) ) = 0;

for ii=1:length(Sabc)
    Sabc(ii,1) =  Sabc(ii,3)*4 + Sabc(ii,2)*2 + Sabc(ii,1);
end

end