%% Notch Filter
NF.Hs=tf([1 0 NF.Wn^2],[1 2*NF.Zeta*NF.Wn NF.Wn^2]);
NF.Hz=c2d(NF.Hs,Ts,'prewarp',NF.Wn);

%% PLL gain setting
PLL.Kp=2*PLL.Zeta*PLL.Wn/E;
PLL.Ki=PLL.Wn^2/E;

%% Voltage controller gain setting
VC.Kp=2*VC.Zeta*VC.Wn*Cdc*Vdc_Oper/(1.5*E);
VC.Ki=VC.Wn^2*Cdc*Vdc_Oper/(1.5*E);
VC.Ka=1/VC.Kp;

%% Current controller gain setting
CC.Kp=Ls_Hat*CC.Wc;
CC.Ki=(Rs_Hat+CC.Ra)*CC.Wc;
CC.Ka=1/CC.Kp;
CC.Kr=Kr_ratio*CC.Ki;



