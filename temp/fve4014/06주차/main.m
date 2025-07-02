%% parameter
close all;
R = 0.26;
L=1.7e-3;
J=2.52e-3;
B=0;
K=0.4078;

Ki = 0;
Kp = 1;

J=0.003;
B=0.001;
TL=0.5;
Stop_Time = 10;
% motor electrical parameter
Po_rated=3000;
Va_rated=100;
Ia_rated=30;

Wrpm_rated=3000;
Wrm_rated = Wrpm_rated/60*2*pi;
Ra=0.3;
La=2.0e-3;

Lf=0.4775;
If_rated=1;

Te_rated=Po_rated/Wrm_rated;

Kt=Te_rated/Ia_rated;
Ke=Kt;

Tm=J*Ra/Kt^2;
Ta=La/Ra;

zeta=0.5*sqrt(Tm/Ta);


% pole zero cancelation
Wcc = 2*pi*50;
Kpc = La * Wcc; 
Kic = Ra * Wcc;
Kac=1/Kpc;


Wsc = 2*pi*10;
Kps = J*Wsc/Kt;
Kis = J*Wsc^2/(5*Kt);
Kas=1/Kps;

SysRL = tf([1], [La Ra]);
SysCCPI = tf([Kpc], [1]) + tf([Kic],[1 0]);
SysCCOL = SysRL*SysCCPI; 


SysCCCL = feedback(SysCCOL, 1);
SysCCCL_Ideal = tf([Wcc], [1 Wcc]);
figure
margin(SysCCCL)
figure
margin(SysCCCL_Ideal)

%%

close all;
SysSCPI = tf([Kps],[1]) + tf([Kis], [1 0]);
SysMech = tf([Kt/J], [1 0]);
SysSCOL = SysSCPI*SysCCCL* SysMech;
SysSCCL = feedback(SysSCOL, 1);

Wpis = Kis/Kps;
figure;
margin(SysSCPI);
figure;
margin(SysMech);
figure;
margin(SysSCOL)
xlim([1 1e4]);
figure;
margin(SysSCPI * SysMech);
%%
close all;
figure;
margin(SysSCOL);
xlim([1 1e4]);
figure
margin(SysSCCL);
xlim([1 1e4]);
figure;
margin(SysCCCL);
xlim([1 1e4]);

% close loop 밴드위쓰 = 92.7 rad
% 반면 open loop 0db 인 지점은 62.8 rad임.

% 전류제어기의 wcc가 속도제어기의 wcs보다 많이 커야
% wcc/(s+wcc) = 1


% -3db = |j/(1+j)| = 1/root(2)
