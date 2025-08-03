clear;
% close all;


[data, fs] = audioread('input.mp3');


dt = 1/fs;
N = length(data);
T_total = dt*N; % sec
t=0:dt:(T_total-dt); % fft라서 0부터시작함.

% set current position
cur_pos = 50*fs;
idx_time = cur_pos-2*fs: cur_pos+2*fs;
t_cur_time = t(idx_time);
data_cur_time = data(idx_time);

% FFT spectrum
Tblk = 0.01;
Nblk = floor( Tblk/dt ); % 0.01초 동안 몇개의 데이터가 있느냐
idx_spectrum = cur_pos:cur_pos+Nblk;
t_blk = t(idx_spectrum);
data_blk = data(idx_spectrum,1);

spec = fft(data_blk); % 0.01초만 fft
spec = abs(spec);

df = 1/Tblk;
freq = 0:df:fs;

% plot time data
hf = figure;
ha1 = axes(hf);
ha1.Position = [ 0.1300    0.6003    0.7750    0.3247];
hold(ha1, 'on');
hp1 = plot(ha1, t, data(:,1));

hp2 = plot(ha1, t_cur_time, data_cur_time,'y');


ha2 = axes(hf); 
ha2.Position = [    0.1300    0.1100    0.7750    0.3669];

hp3 = bar(ha2, freq, spec);



