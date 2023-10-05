clear all
clc

%Laboratorio de Sistemas de Comunicaciones - Andy Paulo Ramirez- - 1087586
%Práctica 5 :  ECUALIZACION

%% Genere un vector de valores binarios aleatorios de l = 10^4 bits, aplique PAM binario (-1, 1)

senal = randi([0 1], 10000);
L = length(senal);

% PAM binario (-1,1)
m = 1;

for i = 1:L
    if senal(i) == 0
        PAM(m) = -1;
    end
    if senal(i) == 1
        PAM(m) = 1;
    end
    m = m + 1;
end

stairs(PAM)
title('PAM binario')
xlim([0 10])
ylim([-1.5 1.5])


%% Haga un Upsample de la senal a 64 mmuestras por simbolo

muestras = 64;   %numero de muestras por simbolo
simbolo = 3;    %cantidad de simbolos 
PAM = times(simbolo,PAM);
n = 1;

for i = 1:L
    for j = 1:muestras
        UP(n) = PAM(i);
        n = n + 1;
    end
end

plot(UP,'r')
title('Señal Upsample (64 muestras/símbolo)')
xlim([0 2000])
ylim([-5 5])

%% Genere un filtro root-raised cosine 

rolloff = 0.6;
filtro = rcosdesign(rolloff, simbolo, muestras);

yout = upfirdn(UP,filtro);
L1 = length(UP);
L2 = length(UP)/64;

% Vector de tiempo
t=linspace(1,L2,L1);


stem (filtro,'m');
title('Respuesta del root-raised cosine filter')
xlim([0 10000])
ylim([-40 40])


%% Agregando ruido al canal
ruido = randn(1,length(yout));
T = yout + ruido.*0.02;

figure
plot(T,'k')
title('Señal con ruido')
xlim([0 10000])
ylim([-40 40])

%% Filtrando la señal
R = upfirdn(T,filtro);

figure
plot(R,'m')
title('Filtrando recepción')
xlim([0 10000])
ylim([-400 400])

% Patrón de ojo de la recepción

n = 64;
eyediagram(R,n,'b')
title('Patrón de ojo de la recepción')
 
%% Zero forcing
hc = [0.6,0.9,0.5];
z = [0;0;1;0;0];
x1 = [0.6 0 0 0 0;0.9 0.6 0 0 0;0.5 0.9 0.6 0 0;0 0.5 0.9 0.6 0;0 0 0.5 0.9 0.6];
x2 = inv(x1);
b = x2*z;
y = conv(b,T);

figure
plot(y,'blue')
title('Señal filtrada')
xlim([0 10000])
ylim([-60 60])

% Patrón de ojo de la recepción (zero forcing equalizer filter)

eyediagram(y,n)
title('Patrón de ojo zero forcing equalizer')






