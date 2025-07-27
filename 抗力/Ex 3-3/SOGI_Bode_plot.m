%% Initialization

clc
clear
close all
format short eng

%% Sogi parameter setting
k=[0.1; 1/sqrt(2); 2];
omega=2*pi*60;

opts=bodeoptions('cstprefs');
opts.FreqUnits='Hz';

figure(1);

for i=1:length(k)
    D(i)=tf([k(i)*omega 0],[1 k(i)*omega omega^2]);
    h(i)=bodeplot(D(i),opts);
    hold on;
end
hold off;
grid on;

ylims{1} = [-60, 20];
ylims{2} = [-100, 100];
setoptions(h(1),'FreqUnits', 'Hz','YLimMode','manual','YLim',ylims);
line = findobj(gcf,'type','line');
set(line,'linewidth',2);
legend('k=0.1', 'k= 1/\surd{2}', 'k=2');

figure(2);
opts=bodeoptions('cstprefs');
opts.FreqUnits='Hz';
% opts.Xlim=

for i=1:length(k)
    Q(i)=tf([k(i)*omega^2],[1 k(i)*omega omega^2]);
    h(i)=bodeplot(Q(i),opts);
    hold on;
end
hold off;
grid on;

ylims{1} = [-60, 20];
ylims{2} = [-190, 10];
setoptions(h(1),'FreqUnits', 'Hz','YLimMode','manual','YLim',ylims);
line = findobj(gcf,'type','line');
set(line,'linewidth',2);
legend('k=0.1', 'k= 1/\surd{2}', 'k=2');
