clear all
clc

%Laboratorio de Sistemas de Comunicaciones - Andy Paulo Ramírez- - 1087586
%Práctica 2 :  Muestreo, Cuantización y Modulación Bandabase (PAM y PCM) 

%% Generando un tono DTMF del numero 7 

fs = 3000;              %Frecuencia de sampleo
f1 = 852;               %Frecuencia 1 para un tono dtmf numero 7 
f2 = 1209;              %Frecuencia 2 para un tono dtmf numero 7
t = 0:1/fs:1;
x = sin(2*pi*f1*t)+sin(2*pi*f2*t);
L = length(x);

sound(x,fs)             %Probando tono 

figure
plot(t,x, 'k');
xlim([0 0.05]);
ylim([-2.5 2.5]);
title('DTMF (7)');
ylabel('Amplitud');
xlabel('tiempo');

% Espectro de frecuencias

y = linspace(0,fs,L)- (fs/2);
n = abs(fftshift(fft(x)));
figure
stem(y,n,'m');
title('FFT DTMF (7)');
ylabel('Magnitud');
xlabel('Frecuencia');

%% Genere un proceso de cuantización a la señal. 

%PAM

M = 16;
k = 4;
q = 0.25;


for i = 1:length(2*x)         %Intervalos de decisión para cuantizar la señal

        if (x(i) >= -2) && (x(i) < -1.75)
           c(i) = 0;
        end
        if (x(i) >= -1.75 && x(i) < -1.50)
           c(i) = 1;
        end
        if (x(i) >= -1.50 && x(i) < -1.25)
           c(i) = 2;
        end
        if (x(i) >= -1.25 && x(i) < -1.00)
           c(i) = 3;
        end
        if (x(i) >= -1.00 && x(i) < -0.75)
           c(i) = 4;
        end
        if (x(i) >= -0.75 && x(i) < -0.50)
           c(i) = 5;
        end
        if (x(i) >= -0.50 && x(i) < -0.25)
           c(i) = 6;
        end
        if (x(i) >= -0.25 && x(i) < 0.00)
           c(i) = 7;
        end
         if (x(i) >= 0.00 && x(i) < 0.25)
           c(i) = 8;
         end
        if (x(i) >= 0.25 && x(i) < 0.50)
           c(i) = 9;
        end
        if (x(i) >= 0.50 && x(i) < 0.75)
           c(i) = 10;
        end
        if (x(i) >= 0.75 && x(i) < 1.00)
           c(i) = 11;
        end
        if (x(i) >= 1.00 && x(i) < 1.25)
           c(i) = 12;
        end
        if (x(i) >= 1.25 && x(i) < 1.50)
           c(i) = 13;
        end
        if (x(i) >= 1.50 && x(i) < 1.75)
           c(i) = 14;
        end
        if (x(i) >= 1.75 && x(i) < 2.00)
           c(i) = 15;
        end
end

f = c(length(c));

figure
stairs([c f], 'b')
title('PAM')
ylabel('Amplitud')
xlabel('tiempo')
xlim([0 100]);
ylim([-2 16]);

% Espectro del PAM

L1 = length(c);
fft1 = linspace(0,fs,L1)- (fs/2);

figure
stem(fft1,abs(fftshift(fft(c))), 'm')
title('FFT PAM');
ylabel('Magnitud');
xlabel('Frecuencia');


%% PCM 

h= [];

for j = 1:L1
    d = dec2bin(c(j),k);            %Conversion de los valores a binario
    h = [h double(d)-48];
end

z = h(length(h));
L2 = length(h);

figure
stairs([h z], 'b');
title('PCM');
ylabel('Amplitud');
xlabel('tiempo');
axis([0 100 -0.5 1.5])

% Espectro del PCM

fft2 = linspace(0,fs,L2)- (fs/2);

figure
stem(fft2,abs(fftshift(fft(h))),'m')
title('FFT PCM');
ylabel('Magnitud');
xlabel('Frecuencia');


%% AWGN al PAM

PAM = c + 0.0001*randn(1,L1);

figure
plot(t,PAM, 'k')
title('PAM con AWGN')
ylabel('Amplitud')
xlabel('tiempo')
axis([0 0.05 -5 20])

% FFT PAM con AWGN

L3 = length(PAM);
fft3 = linspace(0,fs,L3)- (fs/2);

figure
stem(fft3,abs(fftshift(fft(PAM))), 'm')
title('FFT PAM con AWGN');
ylabel('Magnitud');
xlabel('Frecuencia');


%% AWGN PCM

PCM = h + 0.02*randn(1,L2);
L5 = length(PCM);

t1 = 1:L5;
figure
plot(t1,PCM,'k')
title('PCM con AWGN');
ylabel('Amplitud');
xlabel('tiempo');
xlim([0 200]);

% FFT PCM con AWGN

fft4 = linspace(0,fs,L5)- (fs/2);

figure
stem(fft4,abs(fftshift(fft(PCM))),'m')
title('FFT PCM con AWGN');
ylabel('Magnitud');
xlabel('Frecuencia');


