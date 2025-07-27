%% Importing data
Ind_HCC=find(Time>=(Stop_Time-0.1) & Time<Stop_Time);
Time_HCC=Time(Ind_HCC);
I_HCC_On = I_HCC_On(Ind_HCC,1);
I_HCC_Off = I_HCC_Off(Ind_HCC,1);

%% FFT
F1=60;                           % Fundamental Frequency[Hz] (setting)
Ns=6;                            % Number of Periods for Sampling (setting)

Tst_HCC=Time_HCC(end)-1/F1*Ns;
Ind_Tst=min(find(Time_HCC > Tst_HCC));

[Freq, FFT_Off, f1_Before]=FFT_Real(Time_HCC([Ind_Tst:end]), I_HCC_Off([Ind_Tst:end]));
[Freq, FFT_On, f1_After]=FFT_Real(Time_HCC([Ind_Tst:end]), I_HCC_On([Ind_Tst:end]));

Mag_FFT_Off=abs(FFT_Off);
Mag_FFT_On=abs(FFT_On);

for i=1:floor(length(Freq)/Ns/10)
    Freq60(i)=Freq(Ns*i+1);
    Mag_FFT_Off60(i,1)=Mag_FFT_Off(Ns*i+1);
    Mag_FFT_On60(i,1)=Mag_FFT_On(Ns*i+1);
end

figure(6);
bar(Freq60./60, [Mag_FFT_Off60(:,1), Mag_FFT_On60(:,1)]);
title('Harmonic spectrum of grid current', 'FontSize', 12)
xlabel('Harmonic Order','FontSize',12);
ylabel('Magnitude [A]','FontSize',12);
grid on
legend('HCC off', 'HCC on')
xlim([0 10])
ylim([0 25])
