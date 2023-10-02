%% Proyecto Final - Sistema de Comunicacion Inalambrico mediante AM (DSB-SC)
%% Juan Luis Garcia Pe?a #1088276 & Andy Paulo Ramirez #1087586
%% Implementacion en MATLAB - Simulation
clear all 
clc

%% Etapa Upconvertion

%Declarando e Inicializando
Fe= 25; %Frecuencia de la Se?al de Entrada
Fm = 500000; %Frecuencia de Muestreo - Sampling
t = 0:1/Fm:2; %Intervalo de analisis - Abscisa en el Dominio del Tiempo                            
St = sin(2*pi*Fe*t); %Se?al de Entrada - Banda Base

Fc = 356; %Frecuencia de la Se?al Portadora - Carrier
c = cos(2*pi*Fc*t); %Se?al Portadora           
Sm = c.*St; %Se?al Modulada                      
Ruido=0.02.*randn(1,length(Sm)); %Se?al de Ruido Auditivo
k=0.6;

%Graficando Se?al de Informacion S(t) - Tiempo 
figure (1)
plot(t,St,'b') 
ylabel('Amplitud St(t)')
xlabel('Tiempo(s)')
title('Se?al de Informaci?n St(t)')
xlim([0 0.2]); %limite de visualizaci?n
grid

% 'FFT de la Se?al de Informacion'
figure (2)
Fr1 = linspace(0,Fm,length(St))-Fm/2; %Arreglo para la evalucacion en frecuencia
plot(Fr1,abs(fftshift(fft(St))),'r') %Ploteo de la FFT de S(t)
ylabel('Magnitud St(w)')
xlabel('Frecuencia (Hz)')
title('FFT de la Se?al de Informaci?n')
grid
xlim([23 27])%Limite para la correcta visulizaci?n

%Portadora - tiempo
figure(3)
plot(t,c,'b')
xlabel('Tiempo(s)')
ylabel('Amplitud C(t)')
title('Portadora C(t) - Tiempo')
grid
xlim([0 0.014]);%Limite para correcta visualizaci?n

% Portadora - frecuencia 
figure(4)
plot(Fr1,fftshift(abs(fft(c))),'r') 
xlabel('Frecuencia (Hz)')
ylabel('Amplitud C(w)')
title('FFT de la Se?al Portadora - C(w)')
grid
xlim([354 358])%Limite para correcta visualizaci?n

% Se?al Modulada - Tiempo M(t)
figure(5)
plot(t,Sm,'r')
xlabel('Tiempo (s)')
ylabel('Amplitud Sm(t)')
title('Se?al Modulada Sm(t)')
xlim([0 0.1]);
grid

%Graficando las se?ales superpuestas
figure(6)
plot(t,St,'k')
hold on
plot(t,c,'b')
hold on
plot(t,Sm,'r')
xlabel('Tiempo (s)')
ylabel('Amplitud Sm(t)')
title('Se?ales Superpuestas')
xlim([0 0.1]);
hold off

% Se?al Modulada - frecuencia 
figure(7)
plot(Fr1,fftshift(abs(fft(Sm))),'r')
xlabel('Frecuencia (Hz)')
ylabel('Amplitud Sm(w)')
title('FFT de Se?al Modulada Sm(w)')
grid
xlim([330 382])

% % Se?al Demodulada no Filtrada - tiempo figure(8) plot(t,Sd,'k')
% xlabel('Tiempo (s)') ylabel('Magnitud x(t)') title('Se?al Demodulada Sm')
% xlim([0 2]); grid hold on plot(t,St,'r') hold off

% % Se?al DeModulada no Filtrada - Frecuencia figure(9)
% plot(Fr1,fftshift(abs(fft(Sd))),'r'); xlabel('Frecuencia (Hz)')
% ylabel('Amplitud') title('FFT de Se?al Demodulada') grid xlim([0 22])

%% Etapa 2: Respuesta en Frecuencia del Canal
  
%% Simulando para un canal ideal
aten = 1.*Sm; %Atenuando la Se?al para un Canal Ideal
Se2 = aten+Ruido; %A?adiendo el ruido generado a la se?al modulada

%Representacion de la Se?al Canalizada en el Tiempo
figure (8)
plot(t,Se2,'k')
xlabel('Tiempo(s)')
ylabel('Amplitud Sc(t)')
title('Se?al Distorsionada Sc(t) - Tiempo')
xlim([0  0.1])
ylim([-1.2 1.2])
hold on 
plot(t,Sm,'m')
hold off

%Representacion de la Se?al Canalizada en la Frecuencia
figure (9)
plot(Fr1,fftshift(abs(fft(Se2))),'r')
xlabel('Tiempo(s)')
ylabel('Amplitud Sc(w)')
title('Se?al Distorsionada Sc(w) - Frecuencia')
grid
xlim([330 382]) 


%% Simulando para un canal con una Respuesta en Frecuencia Plana 
aten = k.*Sm; %Atenuando la Se?al para un Canal Ideal
Se2 = aten+Ruido; %A?adiendo el ruido generado a la se?al modulada

%Representacion de la Se?al Canalizada en el Tiempo
figure (10)
plot(t,Se2,'k')
xlabel('Tiempo(s)')
ylabel('Amplitud Sc(t)')
title('Se?al Distorsionada Sc(t) - Tiempo - K=0.6')
xlim([0 0.1])
ylim([-1.2 1.2])
hold on 
plot(t,Sm,'m')
hold off

%Representacion de la Se?al Canalizada en la Frecuencia
figure (11)
plot(Fr1,fftshift(abs(fft(Se2))),'r')
xlabel('Tiempo(s)')
ylabel('Amplitud Sc(w)')
title('Se?al Distorsionada Sc(w) - Frecuencia - K=0.6')
grid
xlim([330 382]) 

%% Simulando para un canal con una Respuesta en Frecuencia Experimental
atene = 0.3.*Sm; %Atenuando la Se?al para un Canal Ideal
Se2 = atene+Ruido; %A?adiendo el ruido generado a la se?al modulada

%Representacion de la Se?al Canalizada en el Tiempo - Frecuencia Experimental
figure (12)
plot(t,Se2,'k')
xlabel('Tiempo(s)')
ylabel('Amplitud Sc(t)')
title('Se?al Distorsionada Sc(t) - Tiempo - K=0.3')
xlim([0 0.1])
ylim([-1.2 1.2])
hold on 
plot(t,Sm,'m')
hold off

%Representacion de la Se?al Canalizada en la Frecuencia - Frecuencia Experimental
figure (13)
plot(Fr1,fftshift(abs(fft(Se2))),'r')
xlabel('Tiempo(s)')
ylabel('Amplitud Sc(w)')
title('Se?al Distorsionada Sc(w) - Frecuencia - K=0.3')
grid
xlim([330 382]) 

%% Etapa 3: Downconvertion, Filtrado y Amplificacion
Sd = Se2.*c;  

% Se?al Demodulada no Filtrada - tiempo 
figure(14) 
plot(t,Sd,'k')
xlabel('Tiempo (s)') 
ylabel('Magnitud x(t)') 
title('Se?al Demodulada Sm')
xlim([0 0.1])
ylim([-1.2 1.2])
grid 
hold on 
plot(t,Sm,'r') 
hold off

%Se?al DeModulada no Filtrada - Frecuencia 
figure(15)
plot(Fr1,fftshift(abs(fft(Sd))),'r') 
xlabel('Frecuencia (Hz)')
ylabel('Amplitud') 
title('FFT de Se?al Demodulada') 
grid 
xlim([0 750])

% Filtro Pasa-Bajas - Chebyshev 0.5dB - 38Hz - Topolog?a Sallen-Key de Segundo Orden.
R=313468.864360944; %127361.47577152278; 
Rb=2494950.83846464837; %68000.20512743047226;
C2=0.000000011056751504428517; %0.00000009019341140737405; 
C1=0.000000033;

denom =([R*R*C1*C2 C2*(2*R) 1]);
hs = tf(1,denom)

% Configuracion del Diagrama de Bode
config = bodeoptions;
config.Grid = 'on';
config.FreqUnits = 'Hz';
config.MagUnits = 'abs';
figure(16)
bode(hs,config,'r')

% Analisis en el dominio del tiempo.
figure(17)
title('Se?al demodulada y filtrada superpuestas')
lsim(hs,Sd,t,'k')                                 
xlim([0.6 1])
grid 

% 
% Analisis en dominio de la frecuencia.
figure(18)
plot(Fr1,abs(fftshift(fft(lsim(hs,Sd,t)))),'b')
grid
title('FFT Canal de Salidad D(w))')
xlabel('Frecuencia (Hz)')
ylabel('Magnitud |Y(w)|')
xlim([10 750])
grid 
 
% Amplificando para vencer la atenuacion
Ham=7.31*hs; %6.45; 
figure (19)
title('Se?al transmitida vs se?al recibida vs demodulada ')
lsim(Ham,Sd,t,'k')
xlim([0.6 1])
ylim([-1 1])
grid 
hold on 
plot(t,St,'b')  
hold off


