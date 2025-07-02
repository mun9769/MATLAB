clear all
close all
clc;

T=0.1;
dt=0.00025;

t=0:dt:T;

f=60;
wr=2*pi*f;

P=2;
PP=P/2;

Is=1; %[A]

% 3 phase current
Ias=Is*cos(wr*t);
Ibs=Is*cos(wr*t-2*pi/3);
Ics=Is*cos(wr*t-4*pi/3);

% Spatial Coil Distribution
Thetarm = linspace(-pi,pi,601); % mechanical angle
Thetar = wrapToPi(PP*Thetarm); % Electrical angle


WFa = cos(Thetar);
% WFa = cos(Thetar)>0; % 집중권

WFb = cos(Thetar-2/3*pi);
WFc = cos(Thetar-4/3*pi); 
% 반지름 r = 1, 코일 자기장의 세기는 임의로 정한다. 0.2

R = 1;
Kr_Flux = 0.2;

%%

figure(1);
for i=1:size(t,2) % t의 열크기
    % Ias(i) 는 상수. 즉 [1x1]
    SFa(i,:) = Ias(i)*cos(Thetar); %WFa;  % spacial flux(시간,공간) = 전류 * 고정된 공간
    SFb(i,:) = Ibs(i)*WFb;
    SFc(i,:) = Ics(i)*WFc;
    SFtot(i,:) = SFa(i,:)+SFb(i,:)+SFc(i,:);
    subplot(4,1,1:3)

    plot(R*cos(Thetarm), R*sin(Thetarm),'k')
    hold on
    grid on
    axis([-1.5 1.5 -1.5 1.5]) % 뒤에있어야 속도가빠름
    pbaspect([1 1 1])

    plot((R+Kr_Flux*SFa(i,:)).*cos(Thetarm), ...
        (R+Kr_Flux*SFa(i,:)).*sin(Thetarm),...
        'b', 'Linewidth', 1.5);
    % plot((R+Kr_Flux*SFb(i,:)).*cos(Thetarm), ...
    %     (R+Kr_Flux*SFb(i,:)).*sin(Thetarm),...
    %     'r', 'Linewidth', 1.5);
    % plot((R+Kr_Flux*SFc(i,:)).*cos(Thetarm), ...
    %     (R+Kr_Flux*SFc(i,:)).*sin(Thetarm),...
    %     'g', 'Linewidth', 1.5);
    % plot((R+Kr_Flux*SFtot(i,:)).*cos(Thetarm), ...
    %     (R+Kr_Flux*SFtot(i,:)).*sin(Thetarm),...
    %     'k', 'Linewidth', 1.5);

    
    hold off

    subplot(4,1,4)

    plot(0, 0, 'k'); hold on;
    axis([0 T -1.2*Is, 1.2*Is]); 
    % todo: figure 객체 생성해서 선을 그리는게 아닌 점만 추가.
    % plot은 선을 이어주는 기능을 가진다. 그리고 plot은 점 하나만 추가가 가능하다. 

    plot(t(1:i), Ias(1:i),'LineWidth',2)
    plot(t(1:i), Ibs(1:i),'LineWidth',2)
    plot(t(1:i), Ics(1:i),'LineWidth',2)

    hold off
    pause(0);
end
















