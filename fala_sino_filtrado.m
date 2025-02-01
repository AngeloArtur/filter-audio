pkg load signal;
clc; close all;
[x, fa]=audioread('fala_sino.wav'); %leitura do aúdio
X=fft(x); % transformada de fourier nas componentes do aúdio
T=length(X);
X= X/(T/2); % normalização do sinal
f=[0:T-1]*fa/(T-1);
subplot(2,1,1);
plot(f(1:T/2), abs(X(1:T/2))); xlabel("Frequência"); ylabel("Ganho");
title("Analise espectral de frequência do aúdio original");
sound(x, fa)
