%% Notch Filter
NF.Hs=tf([1 0 NF.Wn^2],[1 2*NF.Zeta*NF.Wn NF.Wn^2]);
NF.Hz=c2d(NF.Hs,Ts,'prewarp',NF.Wn);

%% PLL gain setting
PLL.Kp=2*PLL.Zeta*PLL.Wn/E;
PLL.Ki=PLL.Wn^2/E;

%% Current controller gain setting
CC.Kp=Ls_Hat*CC.Wc;
CC.Ki=(Rs_Hat+CC.Ra)*CC.Wc;
CC.Ka=1/CC.Kp;


