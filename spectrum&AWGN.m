%Laboratorio de Sistemas de Comunicaciones - Andy Paulo Ramírez- - 1087586
%Práctica 1 : Espectro y AWGN

%% Cree una señal periódica con frecuencia de 1kHz utilizando una frecuencia de sampleo de 2000 samples/s

f = 1000;
fs = 2000;
t = 0:1/fs:10;
w = 2*pi*f;
x = cos(w*t);
figure 
plot (t,x,'r');
title ('Señal cosenoidal 1kHz');
ylabel('Magnitud');
xlabel('Tiempo');
xlim([0 0.01]);

%% Genere un vector de igual magnitud con valores aleatorios usando función randn

L = length(x);
aleatoria = randn(1,L);
figure
plot (t,aleatoria, 'k');
title ('Señal con valores aleatorios');
ylabel('Magnitud');
xlabel('Tiempo');
%xlim([0 0.01]);

%% Determine el espectro de la señal cosenoidal

fft1 = linspace(0,fs,L)-(fs/2);
figure 
plot(fft1,abs(fftshift(fft(x))),'r');
title('FFT Señal cosenoidal');
xlim([-2000 2000])
ylabel('Magnitud');
xlabel('Frecuencia');

%% Determine el espectro de la señal con valores aleatorios 

fft2 = linspace(0,fs,L)-(fs/2);
figure 
plot(fft1,abs(fftshift(fft(aleatoria))),'k');
title('FFT Señal aleatoria');
xlim([-2000 2000])
ylabel('Magnitud');
xlabel('Frecuencia');

%% Tome la señal cosenoidal y la señal de valores aleatorios y súmelas en el dominio del tiempo

sum = x + aleatoria;
figure
plot(t, sum, 'm');
title ('Suma de la señal cosenoidal y aleatoria - Dominio del tiempo');
ylabel('Magnitud');
xlabel('Tiempo');

%% Determine el espectro de la señal resultante de la suma 

fft3 = linspace(0,fs,L)-(fs/2);
figure 
plot(fft1,abs(fftshift(fft(sum))),'m');
title('FFT Señal suma');
xlim([-2000 2000])
ylabel('Magnitud');
xlabel('Frecuencia');

%% Tome la señal cosenoidal e incremente la potencia 

potencia = 3*x;
figure 
plot(t,potencia, 'r');
title('Señal cosenoidal con potencia aumentada');
ylabel('Magnitud');
xlabel('Tiempo');
xlim([0 0.01]);

%% Tome la señal con valores aleatorios e incremente el ruido

ruido = 3*aleatoria;
figure 
plot (t,ruido,'k');
title('Señal aleatoria con potencia aumentada');
ylabel('Magnitud');
xlabel('Tiempo');
%xlim([0 0.01]);

%% Tome las señales con potencia aumentada y súmelas en el dominio del tiempo

sum1 = potencia + ruido;
figure
plot(t, sum1, 'm');
title ('Suma de la señal cosenoidal y aleatoria con potencia aumentada');
ylabel('Magnitud');
xlabel('Tiempo');

%% Determine el espectro de la señal cosenoidal con potencia aumentada

fft4 = linspace(0,fs,L)-(fs/2);
figure 
plot(fft4,abs(fftshift(fft(potencia))),'r');
title('FFT Señal cosenoidal potencia aumentada');
xlim([-2000 2000])
ylabel('Magnitud');
xlabel('Frecuencia');


%% Determine el espectro de la señal aleatoria con potencia aumentada

fft5 = linspace(0,fs,L)-(fs/2);
figure 
plot(fft5,abs(fftshift(fft(ruido))),'k');
title('FFT Señal aleatoria potencia aumentada');
xlim([-2000 2000])
ylabel('Magnitud');
xlabel('Frecuencia');

%% Dertermine el espectro de la suma de las señales con potencia aumentada

fft6 = linspace(0,fs,L)-(fs/2);
figure 
plot(fft6,abs(fftshift(fft(sum1))),'m');
title('FFT Suma de señales con potencia aumentada');
xlim([-2000 2000])
ylabel('Magnitud');
xlabel('Frecuencia');




