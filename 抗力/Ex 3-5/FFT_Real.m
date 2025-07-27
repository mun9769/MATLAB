function [Freq,FFT_x, f1] = FFT_Real(t,x)

% t is the time at each sampling. 
% Row of x consist of the value according to t.

Ts=t(2)-t(1);       % Sampling period
N = size(x,1);      % Data size
% x(N,:)=[];
% N = size(x,1);
f1=1/(Ts*N);        % Fundamental Frequency
FFT_x=1/N*fft(x);

N_half=floor((N+1)/2);
Freq=f1*(0:(N_half-1));
FFT_x=FFT_x(1:N_half,:);
FFT_x(2:N_half,:)=2*FFT_x(2:N_half,:);

end
