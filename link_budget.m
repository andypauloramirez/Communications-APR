%Laboratorio de Transmision de senales RF
%Practica enlace de Radio MATLAB
%Andy Paulo Ramirez - 1087586 

close all
clear all
clc  %25.183556

%% PROGRAMA QUE CALCULA EL PRESUPUESTO DEL ENLACE Y GRAFICA LAS GANACIAS DE LAS ANTENAS DE ACUERDO A LA MODULACIÓN

dist_enlace = 10;
dist_enlace_millas = 6.21371;
A = 0.99999;                                        %Disponibilidad 
Undp = 1 - A;                                       %No disponibilidad
perdidas = -4;                                      %Suma de las perdidas (2dB de cada lado) del sistema
a = 1;                                              %Constante para terreno average con ciertas obstrucciones
b = 0.5;                                            %Constante para climas calientes, húmedos y zonas costeras 

%% Para una frecuencia de 11GHz

frecuencia_11 = 11e09;
frecuencia_11_GHz = 11;

%Calculando perdida de espacio libre
lambda_11 = physconst('LightSpeed')/frecuencia_11;  %Valor de longitud de onda (metros) para frecuencia de 11GHz
R_11 = 10e03;                                       %Valor del enlace en metros 
FSL_relativa_11 = fspl(R_11,lambda_11);             %Valor (dB) de perdida de espacio libre sin tomar en cuenta fog y gas

freq_11 = 11e9;                                     %Computando la atenuacion de la señal por gas para el rango de frecuemcia 1-11 GHz
range = 10000;                                      %Computando la atenuacion de la señal por gas para la distancia del enlace (metros)
T = 26;                                             %Temperatura atmosferica (Celcius)
P = 10114;                                          %Presion atmosferica (pascales)
den = 21;                                           %Humedad absoluta del aire (g/m^3) en Rep. Dom.

FSL_gas_11 = gaspl(range,freq_11,T,P,den);          %Valor (dB) de perdida/atenuación por gas 

FSL_fog_11 = fogpl(range,freq_11,T,den);            %Valor (dB) de perdida/atenuación por neblina

FSL_real_11 = (FSL_relativa_11 + FSL_gas_11 + FSL_fog_11)*-1;   %Valor (dB) final de perdida total en el espacio libre 

Fade_Margin_11 = 25.1835; %calculo manual  %(-10)*log10(1e-05/2.5*1*0.5*11*293.9125*1e-06);   %Fade Margin para 11GHz                                   

%% QPSK 

Ptx_QPSK_11 = 28.5;                                 %Potencia de transmisión QPSK 11GHz
threshold_QPSK_11 = -88;                            %Sensibilidad en dBm
RSL_QPSK_11 = threshold_QPSK_11 + Fade_Margin_11;   %Nivel de señal recibido para QPSK 11GHz
Sumatoria_QPSK = FSL_real_11 + perdidas +  Ptx_QPSK_11;

Gain_QPSK_11 = (RSL_QPSK_11 - Sumatoria_QPSK)/2;    %Ganancia de las antenas en dBi

%% 16QAM 

Ptx_16QAM_11 = 28.5;                                 %Potencia de transmisión 16QAM 11GHz
threshold_16QAM_11 = -81;                            %Sensibilidad en dBm
RSL_16QAM_11 = threshold_16QAM_11 + Fade_Margin_11;  %Nivel de señal recibido para 16QAM 11GHz
Sumatoria_16QAM = FSL_real_11 + perdidas +  Ptx_16QAM_11;

Gain_16QAM_11 = (RSL_16QAM_11 - Sumatoria_16QAM)/2;  %Ganancia de las antenas en dBi

%% 32QAM 

Ptx_32QAM_11 = 28.5;                                 %Potencia de transmisión 32QAM 11GHz
threshold_32QAM_11 = -78;                            %Sensibilidad en dBm
RSL_32QAM_11 = threshold_32QAM_11 + Fade_Margin_11;  %Nivel de señal recibido para 32QAM 11GHz
Sumatoria_32QAM = FSL_real_11 + perdidas +  Ptx_32QAM_11;

Gain_32QAM_11 = (RSL_32QAM_11 - Sumatoria_32QAM)/2;  %Ganancia de las antenas en dBi

%% 64QAM 

Ptx_64QAM_11 = 28.5;                                 %Potencia de transmisión 64QAM 11GHz
threshold_64QAM_11 = -74.5;                          %Sensibilidad en dBm
RSL_64QAM_11 = threshold_64QAM_11 + Fade_Margin_11;  %Nivel de señal recibido para 64QAM 11GHz
Sumatoria_64QAM = FSL_real_11 + perdidas +  Ptx_64QAM_11;

Gain_64QAM_11 = (RSL_64QAM_11 - Sumatoria_64QAM)/2;  %Ganancia de las antenas en dBi

%% 128QAM 

Ptx_128QAM_11 = 28.5;                                 %Potencia de transmisión 128QAM 11GHz
threshold_128QAM_11 = -71.5;                          %Sensibilidad en dBm
RSL_128QAM_11 = threshold_128QAM_11 + Fade_Margin_11; %Nivel de señal recibido para 128QAM 11GHz
Sumatoria_128QAM = FSL_real_11 + perdidas +  Ptx_128QAM_11;

Gain_128QAM_11 = (RSL_128QAM_11 - Sumatoria_128QAM)/2; %Ganancia de las antenas en dBi


%% 256QAM 

Ptx_256QAM_11 = 26.5;                                 %Potencia de transmisión 256QAM 11GHz
threshold_256QAM_11 = -68.5;                          %Sensibilidad en dBm
RSL_256QAM_11 = threshold_256QAM_11 + Fade_Margin_11; %Nivel de señal recibido para 256QAM 11GHz
Sumatoria_256QAM = FSL_real_11 + perdidas +  Ptx_256QAM_11;

Gain_256QAM_11 = (RSL_256QAM_11 - Sumatoria_256QAM)/2; %Ganancia de las antenas en dBi

%% 512QAM 

Ptx_512QAM_11 = 26.5;                                 %Potencia de transmisión 512QAM 11GHz
threshold_512QAM_11 = -66.5;                          %Sensibilidad en dBm
RSL_512QAM_11 = threshold_512QAM_11 + Fade_Margin_11; %Nivel de señal recibido para 512QAM 11GHz
Sumatoria_512QAM = FSL_real_11 + perdidas +  Ptx_512QAM_11;

Gain_512QAM_11 = (RSL_512QAM_11 - Sumatoria_512QAM)/2; %Ganancia de las antenas en dBi

%% 1024QAM 

Ptx_1024QAM_11 = 25.5;                                 %Potencia de transmisión 1024QAM 11GHz
threshold_1024QAM_11 = -63;                            %Sensibilidad en dBm
RSL_1024QAM_11 = threshold_1024QAM_11 + Fade_Margin_11;%Nivel de señal recibido para 1024QAM 11GHz
Sumatoria_1024QAM = FSL_real_11 + perdidas +  Ptx_1024QAM_11;

Gain_1024QAM_11 = (RSL_1024QAM_11 - Sumatoria_1024QAM)/2; %Ganancia de las antenas en dBi

%% 2048QAM 

Ptx_2048QAM_11 = 23.5;                                 %Potencia de transmisión 2048QAM 11GHz
threshold_2048QAM_11 = -60;                            %Sensibilidad en dBm
RSL_2048QAM_11 = threshold_2048QAM_11 + Fade_Margin_11;%Nivel de señal recibido para 2048QAM 11GHz
Sumatoria_2048QAM = FSL_real_11 + perdidas +  Ptx_2048QAM_11;

Gain_2048QAM_11 = (RSL_2048QAM_11 - Sumatoria_2048QAM)/2; %Ganancia de las antenas en dBi




%% Para una frecuencia de 23GHz

frecuencia_23 = 23e09;
frecuencia_23_GHz = 23;

%Calculando perdida de espacio libre
lambda_23 = physconst('LightSpeed')/frecuencia_23;  %Valor de longitud de onda (metros) para frecuencia de 23GHz
R_23 = 10e03;                                       %Valor del enlace en metros 
FSL_relativa_23 = fspl(R_23,lambda_23);             %Valor (dB) de perdida de espacio libre sin tomar en cuenta fog y gas

freq_23 = 23e9;                                     %Computando la atenuacion de la señal por gas para el rango de frecuemcia 23 GHz

FSL_gas_23 = gaspl(range,freq_23,T,P,den);          %Valor (dB) de perdida/atenuación por gas 

FSL_fog_23 = fogpl(range,freq_23,T,den);            %Valor (dB) de perdida/atenuación por neblina

FSL_real_23 = (FSL_relativa_23 + FSL_gas_23 + FSL_fog_23)*-1;   %Valor (dB) final de perdida total en el espacio libre 

Fade_Margin_23 = 28.387;  %(-10)*log10((1e-05/(2.5*1*0.5*23*293.9125*(10e-06))));   %Fade Margin para 23GHz  


%% QPSK 

Ptx_QPSK_23 = 24;                                   %Potencia de transmisión QPSK 23GHz
threshold_QPSK_23 = -87.5;                          %Sensibilidad en dBm
RSL_QPSK_23 = threshold_QPSK_23 + Fade_Margin_23;   %Nivel de señal recibido para QPSK 23GHz
Sumatoria_QPSK_23 = FSL_real_23 + perdidas +  Ptx_QPSK_23;

Gain_QPSK_23 = (RSL_QPSK_11 - Sumatoria_QPSK_23)/2; %Ganancia de las antenas en dBi

%% 16QAM 

Ptx_16QAM_23 = 23;                                   %Potencia de transmisión 16QAM 23GHz
threshold_16QAM_23 = -80.5;                          %Sensibilidad en dBm
RSL_16QAM_23 = threshold_16QAM_23 + Fade_Margin_23;  %Nivel de señal recibido para 16QAM 23GHz
Sumatoria_16QAM_23 = FSL_real_23 + perdidas +  Ptx_16QAM_23;

Gain_16QAM_23 = (RSL_16QAM_23 - Sumatoria_16QAM_23)/2;  %Ganancia de las antenas en dBi

%% 32QAM 

Ptx_32QAM_23 = 23;                                   %Potencia de transmisión 32QAM 23GHz
threshold_32QAM_23 = -77.5;                          %Sensibilidad en dBm
RSL_32QAM_23 = threshold_32QAM_23 + Fade_Margin_23;  %Nivel de señal recibido para 32QAM 23GHz
Sumatoria_32QAM_23 = FSL_real_23 + perdidas +  Ptx_32QAM_23;

Gain_32QAM_23 = (RSL_32QAM_23 - Sumatoria_32QAM_23)/2;  %Ganancia de las antenas en dBi

%% 64QAM 

Ptx_64QAM_23 = 22;                                   %Potencia de transmisión 64QAM 23GHz
threshold_64QAM_23 = -74;                            %Sensibilidad en dBm
RSL_64QAM_23 = threshold_64QAM_23 + Fade_Margin_23;  %Nivel de señal recibido para 64QAM 23GHz
Sumatoria_64QAM_23 = FSL_real_23 + perdidas +  Ptx_64QAM_23;

Gain_64QAM_23 = (RSL_64QAM_23 - Sumatoria_64QAM_23)/2;  %Ganancia de las antenas en dBi

%% 128QAM 

Ptx_128QAM_23 = 22;                                   %Potencia de transmisión 128QAM 23GHz
threshold_128QAM_23 = -71;                            %Sensibilidad en dBm
RSL_128QAM_23 = threshold_128QAM_23 + Fade_Margin_23; %Nivel de señal recibido para 128QAM 23GHz
Sumatoria_128QAM_23 = FSL_real_23 + perdidas +  Ptx_128QAM_23;

Gain_128QAM_23 = (RSL_128QAM_23 - Sumatoria_128QAM_23)/2; %Ganancia de las antenas en dBi


%% 256QAM 

Ptx_256QAM_23 = 19.5;                                 %Potencia de transmisión 256QAM 23GHz
threshold_256QAM_23 = -68;                            %Sensibilidad en dBm
RSL_256QAM_23 = threshold_256QAM_23 + Fade_Margin_23; %Nivel de señal recibido para 256QAM 23GHz
Sumatoria_256QAM_23 = FSL_real_23 + perdidas +  Ptx_256QAM_23;

Gain_256QAM_23 = (RSL_256QAM_23 - Sumatoria_256QAM_23)/2; %Ganancia de las antenas en dBi

%% 512QAM 

Ptx_512QAM_23 = 19.5;                                   %Potencia de transmisión 512QAM 23GHz
threshold_512QAM_23 = -66;                              %Sensibilidad en dBm
RSL_512QAM_23 = threshold_512QAM_23 + Fade_Margin_23;   %Nivel de señal recibido para 512QAM 23GHz
Sumatoria_512QAM_23 = FSL_real_23 + perdidas +  Ptx_512QAM_23;

Gain_512QAM_23 = (RSL_512QAM_23 - Sumatoria_512QAM_23)/2; %Ganancia de las antenas en dBi

%% 1024QAM 

Ptx_1024QAM_23 = 18;                                    %Potencia de transmisión 1024QAM 23GHz
threshold_1024QAM_23 = -62.5;                           %Sensibilidad en dBm
RSL_1024QAM_23 = threshold_1024QAM_23 + Fade_Margin_23; %Nivel de señal recibido para 1024QAM 23GHz
Sumatoria_1024QAM_23 = FSL_real_23 + perdidas +  Ptx_1024QAM_23;

Gain_1024QAM_23 = (RSL_1024QAM_23 - Sumatoria_1024QAM_23)/2; %Ganancia de las antenas en dBi

%% 2048QAM 

Ptx_2048QAM_23 = 16;                                    %Potencia de transmisión 2048QAM 11GHz
threshold_2048QAM_23 = -59.5;                           %Sensibilidad en dBm
RSL_2048QAM_23 = threshold_2048QAM_23 + Fade_Margin_23; %Nivel de señal recibido para 2048QAM 11GHz
Sumatoria_2048QAM_23 = FSL_real_23 + perdidas +  Ptx_2048QAM_23;

Gain_2048QAM_23 = (RSL_2048QAM_23 - Sumatoria_2048QAM_23)/2; %Ganancia de las antenas en dBi


%Sacando la grafica para 11GHz
d_11 =[1 2 3 4 5 6 7 8 9];
gains_11 = [Gain_QPSK_11 Gain_16QAM_11 Gain_32QAM_11 Gain_64QAM_11 Gain_128QAM_11 Gain_256QAM_11 Gain_512QAM_11 Gain_1024QAM_11 Gain_2048QAM_11];

d_23 =[1 2 3 4 5 6 7 8 9];
gains_23 = [Gain_QPSK_23 Gain_16QAM_23 Gain_32QAM_23 Gain_64QAM_23 Gain_128QAM_23 Gain_256QAM_23 Gain_512QAM_23 Gain_1024QAM_23 Gain_2048QAM_23];

plot(d_11, gains_11,'blue')
title('Grafico de ganancias vs modulación para 11GHz y 23GHz')
hold on
%Sacando la grafica para 23GHz
plot(d_23, gains_23,'k')
xlim ([0.5 9.5])
ylim([20 90])
xlabel ('Modulacion QPSK-2048QAM')
ylabel ('Ganancia dBi')
legend ('11GHz','23GHz')
hold off



