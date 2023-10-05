clear all
clc

%Laboratorio de Sistemas de Comunicaciones - Andy Paulo Ramírez- - 1087586
%Práctica 3 :  Códigos de línea 

%% Creando vector de valores binarios aleatorios (señal de información)

x = randi([0 1],1000,1);

%% Codigo de linea NON RETURN ZERO UNIPOLAR 

stairs(x,'k')
title('NRZ Unipolar')
grid
xlim([0 20]);
ylim([-0.2 1.2]);

% FFT NRZ unipolar

Fs = 4000;
L1=length(x);
F1= linspace(0,Fs,L1)-(Fs/2);

figure
stem(F1,abs(fftshift(fft(x))),'m');
title('FFT NRZ unipolar');
xlim([-2000 2000])

%% Codigo de linea NON RETURN ZERO BIPOLAR

y = [];
for j = 1:1000
    if(x(j) == 1)
        y(j) = 1;
    end
    if(x(j) == 0)
        y(j) = -1;
    end
end

stairs(y,'k')
title('NRZ bipolar')
grid
xlim([0 20]);
ylim([-1.2 1.2]);

% FFT NRZ bipolar
L2 = length(y);
F2= linspace(0,Fs,L2)-(Fs/2);

figure
stem(F2,abs(fftshift(fft(y))),'m');
title('FFT NRZ bipolar');
xlim([-2000 2000])

%% Codigo de linea RETURN ZERO UNIPOLAR

t = 0:0.01:length(y);
t1 = 0;
t2 = 0.5;
i = 1;
for j = 1:length(t)
    if((t(j) >= t1) && (t(j)<= t2))
        w(j) = x(i);
    elseif((t(j)> t2) && (t(j) <= i))
        w(j) = 0;
    else
        i = i + 1;
        t1 = t1 + 1;
        t2 = t2 + 1;
    end
end

figure
stairs(t,w,'k')
grid
title('RZ Unipolar')
xlim([0 20]);
ylim([-0.2 1.2]);

% FFT RZ unipolar

L3 = length(w);
F3 = linspace(0,Fs,L3)- Fs/2;

figure
stem(F3,abs(fftshift(fft(w))),'m')
title('FFT RZ unipolar')
xlim([-2000 2000])

%% Codigo de linea RETURN ZERO BIPOLAR 

i = 1;
t = 0:0.01:length(x);

t1 = 0;
t2 = 0.5;

for j = 1:length(t)
    if((t(j) >= t1) && (t(j)<= t2))
        z(j) = y(i);
    elseif( (t(j)> t2) && (t(j) <= i))
        z(j) = 0;
    else
        i = i + 1;
        t1 = t1 + 1;
        t2 = t2 + 1;
    end
end

figure
stairs(t,z,'k')
grid
title('RZ bipolar')
xlim([0 20]);
ylim([-1.2 1.2]);

% FFT RZ bipolar

L4 = length(z);
F4 = linspace(0,Fs,L4)- Fs/2;

figure
stem(F4,abs(fftshift(fft(z))),'m')
title('FFT RZ bipolar')
xlim([-2000 2000])

%% Codigo de linea MANCHESTER IEEE 802.3

i = 1;

t = 0:0.01:length(y);
t1 = 0;
t2 = 0.5;

for j = 1:length(t)
    if ((t(j) >= t1) && (t(j) <= t2))
        k(j) = -y(i);

    elseif ( (t(j) > t2) &&(t(j) <= i))
        k(j) = y(i);
    else
        i = i + 1;
        t1 = t1 + 1;
        t2 = t2 + 1;
    end
end

for j = 1:length(k)
    if k(j) == 0
        k(j) = k(j-1);
    end
end

figure
stairs(t,k,'k')
grid
title('Manchester IEEE')
xlim([0 10]);
ylim([-1.2 1.2]);

% FFT Manchester IEEE 802.3

Fs = 4000;

L5 = length(k);
F5 = linspace(0,Fs,L5)- Fs/2;

figure
stem(F5,abs(fftshift(fft(k))),'m')
title('FFT Manchester IEEE')
xlim([-2000 2000])


%% Codigo de linea AMI 

n = 0;
for j = 1:1000
    if y(j) == 1
        n = n + 1;
        if mod(n,2) == 0
            p(j) = -y(j);
        else
            p(j) = y(j);
        end

    end
    if y(j) == 0
        p(j) = 0;
    end
end

figure
stairs(p,'k')
grid
title('AMI')
xlim([0 20]);
ylim([-1.6 1.6]);

% Espectro del AMI.

L6 = length(p);
F6 = linspace(0,Fs,L6)- Fs/2;

figure
stem(F6,abs(fftshift(fft(p))),'m')
title('FFT AMI')
xlim([-2000 2000])





