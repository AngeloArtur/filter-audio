pkg load signal;
clc; close all;
[x, fa]=audioread('fala_sino.wav'); %leitura do áudio

X=fft(x); % transformada de fourier nas componentes do áudio
T=length(X);
X= X/(T/2); % normalização do sinal
f=[0:T-1]*fa/(T-1);
plot(f(1:T/2), abs(X(1:T/2))); xlabel("Frequência"); ylabel("Amplitude");
title("Analise espectral de frequência do áudio original");

N =10;
w = 1280/(fa/2);

[b, a] = butter(N, w);
[H, W] = freqz(b, a, 512, fa);

b_fir = fir1(N, w); %comparando os dois filtros

[H_fir, W_fir] = freqz(b_fir, 1, 512, fa);
figure;
plot(f(1:T/2), abs(X(1:T/2)), W, abs(H)); xlabel("Frequência"); ylabel("Amplitude");
title("Filtro Butterworth passa-baixas");

figure;
plot(f(1:T/2), abs(X(1:T/2)), W, abs(H), W_fir, abs(H_fir)); xlabel("Frequência"); ylabel("Amplitude");
title("Comparação entre o filtro butterworth e o filtro fir1")
legend("Espectro", "Filtro Butterworth", "Filtro FIR1");

y = filtra_iir(b, a, x); % filtro do sinal
Y = fft(y); Y = Y/(T/2);

y_fir = filtra_iir(b_fir, 1, x); % filtro do b_fir1
Y_fir = fft(y_fir); Y_fir = Y_fir/(T/2);

figure;
plot(f(1:T/2), abs(Y_fir(1:T/2)));  xlabel("Frequência"); ylabel("Amplitude");
title("Análise espectral do áudio filtrado com fir1");

figure;
plot(f(1:T/2), abs(Y(1:T/2)));  xlabel("Frequência"); ylabel("Amplitude");
title("Análise espectral do áudio filtrado");

[H, Z] = impz(b, a);
figure;
plot(Z, abs(H)); xlabel("Tempo"); ylabel("Amplitude");
title("Respota ao impulso do Filtro");

sound(y, fa);
%sound(y_fir, fa); %áudio utilizando o filtro fir1
