pkg load signal;
clc; close all;
[x, fa]=audioread('fala_ruido2.wav'); %leitura do aúdio
X=fft(x); % transformada de fourier nas componentes do aúdio
T=length(X);
X= X/(T/2); % normalização do sinal
f=[0:T-1]*fa/(T-1);
subplot(2,1,1);
plot(f(1:T/2), abs(X(1:T/2))); xlabel("Frequência"); ylabel("Ganho");
title("Analise espectral de frequência do aúdio original");

wc = (2*pi)*(550)/fa
wc2 = (2*pi*1750/fa); % selecionado a frequência que deseja recortar
r = 0.97; %Raio da circunferência unitária
b = [1 -2*cos(wc) 1] %coeficientes da equação numerador
a = [1 -2*r*cos(wc) r^2] %coeficientes da equação denominador
[H, W] = freqz(b, a, 512, fa); % sistema, num, num. pontos, frequência de amostragem
subplot(2,1,2);
title("Usando o filtro noch e retirando a componente de 550 Hz")
plot(f(1:T/2), abs(X(1:T/2)),W, abs(H));

y = filter(b, a, x); % filtro do sinal
#y_iir = filtra_iir(b, a, x);
Y = fft(y); Y = Y/(T/2);
#Y_iir = fft(y_iir); Y_iir = Y_iir/(T/2);

figure;
subplot(2,1,1);
plot(f(1:T/2), abs(Y(1:T/2)));  xlabel("Frequência"); ylabel("Amplitude");
title("Aplicação do primeiro filtro normal ");

#subplot(2,1,2);
#plot(f(1:T/2), abs(Y_iir(1:T/2)));  xlabel("Frequência"); ylabel("Amplitude");
#title("Aplicação do primeiro filtro iir ");

wc2 = 2*pi*1750/fa;
b2 = [1 -2*cos(wc2) 1] %coeficientes da equação numerador
a2 = [1 -2*r*cos(wc2) r^2] %coeficientes da equação denominador
[H2, W2] = freqz(b2, a2, 512, fa); % sistema, num, num. pontos, frequência de amostragem
subplot(2,1,2);
plot(f(1:T/2), abs(Y(1:T/2)),W2, abs(H2));

y2 = filter(b2, a2, y); % filtro do sinal
%y_iir2 = filtra_iir(b2, a2, y_iir);
Y2 = fft(y2); Y2 = Y2/(T/2);
#y_iir =  filtra_iir(x, a, y_iir);
figure;
plot(f(1:T/2), abs(Y2(1:T/2)));  xlabel("Frequência"); ylabel("Ganho");
title("Aplicação do segundo filtro ");

%resposta ao impulso
[H,Z] = impz(b2, a2);
figure;
plot(Z, abs(H)); xlabel("Tempo"); ylabel("Amplitude");
title("Respota ao impulso do Filtro");
sound(y2, fa);

