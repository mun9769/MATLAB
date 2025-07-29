function [Sabc, Vdqss_Ref, ta, tt] = my_param(logsout)

Vdqss_Ref =  logsout.get("Vdqss_Ref").Values.Data;
tt =         logsout.get("Vdqss_Ref").Values.Time;

Sabc =  logsout.get("Sabc").Values.Data ;
ta =    logsout.get("Sabc").Values.Time;

% Vdqss_Ref = interp1(tt, Vdqss_Ref, ta, 'previous');
% Vdqss_Ref( isnan(Vdqss_Ref) ) = 0;

for ii=1:length(Sabc)
    Sabc(ii,1) = Sabc(ii,1) + Sabc(ii,2)*2 + Sabc(ii,3)*4; % todo: 꺼꾸로 했나?
end

end