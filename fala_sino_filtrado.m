pkg load signal;
clc; close all;
[x, fa]=audioread('fala_sino.wav'); %leitura do áudio

X=fft(x); % transformada de fourier nas componentes do áudio
T=length(X);
X= X/(T/2); % normalização do sinal
f=[0:T-1]*fa/(T-1);
plot(f(1:T/2), abs(X(1:T/2))); xlabel("Frequência"); ylabel("Amplitude");
title("Analise espectral de frequência do áudio original");

N = 2;
w = 100/(fa/2);
[n, Wn] = buttord(w, 2000/(fa/2), 1, 2)
[b, a] = butter(n, Wn);
[H, W] = freqz(b, a, 512, fa);
figure;
plot(f(1:T/2), abs(X(1:T/2)), W, abs(H))

y = filter(b, 1, x); % filtro do sinal
Y = fft(y); Y = Y/(T/2);

figure;
plot(f(1:T/2), abs(Y(1:T/2)));


sound(y, fa)
