clear all
clc

%Laboratorio de Comunicaciones Digitales - Andy Paulo Ramírez- - 1087586
%Práctica 1 :  Modulación AM y FM 

%% Generando una onda coseno con frecuencia de 10 Hz 

fs = 500;
fm = 10;
t = 0:1/fs:1;
m =  cos(2*pi*fm*t);                %Señal de información
L = length(m);

figure 
plot(t,m)                           %Gráfica en el dominio del tiempo
xlim([0 0.5]);
ylim([-1.5 1.5]);
title('Señal de información');
ylabel('Amplitud');
xlabel('tiempo (s)');

%Espectro de la señal de información
y = linspace(0,fs,L)- (fs/2);
n = abs(fftshift(fft(m)));
figure
stem(y,n,'m');
xlim([-50 50])
title('FFT Señal de información');
ylabel('Magnitud');
xlabel('Frecuencia (Hz)');

%% Generando una onda coseno de amplitud 0.5 y frecuencia de 100 Hz

fc = 100;
c = 0.5*cos(2*pi*fc*t);               %Señal portadora (carrier)
L2 = length(c);

figure 
plot(t,c,'k')
xlim([0 0.5]);
ylim([-1 1]);
title('Señal portadora (carrier)');         %Dominio del tiempo
ylabel('Amplitud');
xlabel('tiempo (s)');

y2 = linspace(0,fs,L2)- (fs/2);
n2 = abs(fftshift(fft(c)));
figure
stem(y2,n2,'m');
ylim([0 130]);
title('FFT Señal portadora');               %Dominio de la frecuencia
ylabel('Magnitud');
xlabel('Frecuencia (Hz)');

figure 
plot(t,m) 
xlim([0 0.5]);
ylim([-1.5 1.5]);
hold on
plot(t,c,'k')
hold off


%% Modulando la señal por amplitud AM

Sam = c.*(1 + m);
L3 = length(Sam);

figure 
plot(t,Sam,'blue')                      %Dominio del tiempo
xlim([0 0.5]);
ylim([-1.5 1.5]);
title('Señal modulada por amplitud (AM)');
ylabel('Amplitud');
xlabel('tiempo (s)');

y3 = linspace(0,fs,L3)- (fs/2);
n3 = abs(fftshift(fft(Sam)));
figure
stem(y3,n3,'m');                        %Dominio de la frecuencia
ylim([0 130]);
title('FFT Señal Modulada (AM)');
ylabel('Magnitud');
xlabel('Frecuencia (Hz)');


%% Modulando la señal por frecuencia FM

kf = 1;
Sfm = 0.5*cos(2*pi*fc*t+(2*pi*kf.*sin(2*pi*fm*t)));
L4 = length(Sfm);

figure 
plot(t,Sfm)
xlim([0 0.5]);
ylim([-1.5 1.5]);
title('Señal modulada por frecuencia (FM)');      %Dominio del tiempo
ylabel('Amplitud');
xlabel('tiempo (s)');

y4 = linspace(0,fs,L4)- (fs/2);
n4 = abs(fftshift(fft(Sfm)));
figure
stem(y4,n4,'m');                        %Dominio de la frecuencia
ylim([0 130]);
title('FFT Señal Modulada (FM)');
ylabel('Magnitud');
xlabel('Frecuencia (Hz)');


%% Modulando la señal con AM con Ac=2

Ac = 2;
c2 = Ac*cos(2*pi*fc*t);

Sam2 = c2.*(1 + m);
L5 = length (Sam2);

figure 
plot(t,Sam2,'k')                      %Dominio del tiempo
xlim([0 0.5]);
ylim([-4.5 4.5]);
title('Señal modulada por amplitud (AM) con Ac = 2');
ylabel('Amplitud');
xlabel('tiempo (s)');

hold on
plot(t,Sam,'m') 
hold off

y5 = linspace(0,fs,L5)- (fs/2);
n5 = abs(fftshift(fft(Sam2)));
figure
stem(y5,n5,'m');                        %Dominio de la frecuencia
ylim([0 500]);
title('FFT Señal modulada por amplitud (AM) con Ac = 2');
ylabel('Magnitud');
xlabel('Frecuencia (Hz)');



