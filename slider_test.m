clear; close all;
n = -10:10; x = (0.9).^n;
k = -100:100; 
w = (pi/25)*k; 
X = x * (exp(-j*pi/100)) .^ (n'*k);
magX = abs(X); angX =angle(X);


subplot(2,1,1); 
p1 = plot(w/pi/2,magX, 'r.');grid; %axis([-1,1,0,15])
ylabel('|X|')
title('Magnitude Part')
subplot(2,1,2); 
p2 = plot(w/2/pi,angX/pi, 'r-');grid; 

% axis([-1,1,-2,2])
xlabel('Frequency in \pi Units'); ylabel('Radians/\pi')
title('Angle Part')

t1 = text(0,0,'');

for ii= 100:400
    k=-ii:ii;
    w=(2*pi/ii) * k;
    
    X = x * (exp(-j*2*pi/ii)) .^ (n'*k);
    
    magX = abs(X);
    angX = angle(X);

    p1.XData = w;
    p2.XData = w;
    p1.YData = magX;
    p2.YData = angX;
    t1.String = ['k: ' num2str(ii,'%.0f')];
    pause(0.2)
end


%%
clear;
close all;
b= 1; 
global a;
global p2;
global x;
global b;

a=[1 -0.8]; % y[n] - 0.8y[n-1] = x[n]

n=0:100;
f =0.025;
x=cos(2*pi*f*n); % n과 t의 차이?

y=filter(b,a,x);

fig = figure;
ha = axes(fig);
hold on;
p1 = plot(ha, n, x);
p2 = plot(ha, n, y);



s = uicontrol('parent', fig, 'style', 'slider', ...
    'min', 0, 'max', 3, 'value', 0.2, ...
    'Position', [10, 5, 400, 20], ...
    'callback', @slider_callback);

function slider_callback(hObject, event)
    global a p2 x b;
    val = get(hObject, 'value');
    
    a(2) = -val;


y=filter(b,a,x);
p2.YData = y;

    disp(['slider value= ' num2str(val)]);
end



