clear all
clc

%Laboratorio de Comunicaciones Digitales - Andy Paulo Ramírez- - 1087586
%Práctica 1 :  Modulación ASK

%% Generando un vector de bits aleatorios 

Data=randi([0,1], 1,10e5); %Data de bits aleatorios
UData=[];
%% UpSample
for i=Data
for j=1:100
UData=[UData,i];
end
end
t1 = linspace(0, 1, 10000);
figure (1) %Señal de Información UP
plot (t1,UData,'r');
xlabel ('Tiempo (seg)');
ylabel ('Amplitud');
title ('Señal de Información con Up Sample');
ylim ([-0.2 1.2])
%% Ejecución de Función para Modular
[SData,t] =Modulador(UData,2,1);
figure (2) %Señal de Información UP
plot (t,SData,'k');
xlabel ('Tiempo (seg)');
ylabel ('Amplitud');
title ('Señal de Información Modulada / BASK');
ylim ([-0.6 0.6])
%% BER y SNR
SNRdB = 0: 1: 10;
SNR = 10.^(SNRdB/10);
BER_sim = zeros(1, length(SNR));
datarec = zeros(length(Data), 1);
Es = ((max(SData).^2) + (min(SData).^2))/2;
for i=1:length(SNR)
doble_var_n = Es/SNR(i);
n = (randn(1, length(SData)) * sqrt(doble_var_n / 2))/2 + i*(randn(1, length(SData)) * sqrt(doble_var_n / 2))/2;
rec = SData + n;
k = 1;
thr = 0;
for z=SData
if (z>(0.5-thr) || z<(-0.5+thr))
AMID=[AMID, 1];
else
AMID=[AMID, 0];
end
end
error = sum(datarec ~= Data.');
BER_sim(i) = error/length(datarec);
end
figure(3)
semilogy(SNRdB, BER_sim, '*-')
title('BER de Señal transmitida BPSK')

xlabel('SNR(dB)')
ylabel('BER')
figure(4)
scatterplot(rec)
%% Function que modula la data en ASK-OOK... Paràmetros: Data, Tipo de Mod y Distancia de Hammming
% A=DH*(L-1)/2;
function [DM,t2] = Modulador(In, M, DH)
Fs =1e6; %Frecuencia de Muestreo 1Mhz
NIn=repelem(In,10); %Adaptando Array de In
NIn=[NIn, 0];
time = 0.1;
t2=[0:1/Fs:time];%Vector de tiempo, 100000 muestras
switch M
case 2%ASK-OOK
A=DH/2;
DM=A*(NIn).*cos(2*pi*10e4*t2);
otherwise
disp('Not Posible')
end
end