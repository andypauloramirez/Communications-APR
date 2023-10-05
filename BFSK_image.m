%Comunicaciones Digitales
%Andy Paulo Ramirez-1087586 
%Julio Francisco Nuñez
%Proyecto final: Sistema de comunicaciones digitales para compañías
clc
clear 

%% Parte 1: Tomar una informacion (imagen) convertirla a un stream de bits (bitstream) 

% Ia= imread('imagen.jpeg');
% I = imresize(Ia, [256 256]);
% figure
% imshow(I)
% 
% J_A = I(1:size(I,1),1:size(I,2),1);
% J_B = 0;%I(1:size(I,1),1:size(I,2),2);
% J_C = 0;%I(1:size(I,1),1:size(I,2),3);
% imshow(J_A)
% % % % K = cat(3,J_A,J_B,J_C);
% % % % figure
% % % % imshow(K)
% 
% A = reshape(J_A,[],1);
% B = reshape(J_B,[],1);
% C = reshape(J_C,[],1);
% 
% % % % AR = reshape(A,size(J_A,1),size(J_A,2));
% % % % BR = reshape(B,size(J_B,1),size(J_B,2));
% % % % CR = reshape(C,size(J_C,1),size(J_C,2));
% % % % 
% % % % K = cat(3,AR,BR,CR);
% % % % figure
% % % % imshow(K)
% 
% Z = [A;B;C];
% 
% U = de2bi(Z);
% bitstream = reshape(U,[],1);
% 
% figure (2)
% stairs(bitstream)
% title('Senal de Bits de informacion de la Imagen');
% xlabel('Cantidad de muestras');
% ylabel('Amplitud');
% axis([0 30e01 -0.5 1.5])

%% Generando un vector de bits aleatorios 

 bitstream = randi([0,1],1,10e3); % Bits de data aleatoria.





%% Modulación de la señal - Modulaciones a utilizar 

        %BFSK           %BPSK           %QAM

 %% Modulacion BFSK para la señal 
% Fs1 = 1000e8;                    %frecuencia de muestreo       
% T1 = 1/Fs1;                       %periodo de muestreo
% t1 = 0:T1:0.00000001;             %vector de tiempo
% f1_1 = 1100e6;                  %frecuencia portadora 1
% f2_1 = 1200e6;                  %frecuencia portadora 2
% portadora1BFSK = cos(2*pi*f1_1*t1);  %portadora 1
% portadora2BFSK = cos(2*pi*f2_1*t1);  %portadora 2
% 
% figure(1)
% subplot(2,1,1)
% plot(t1,portadora1BFSK)
% xlim([0 0.000000005])
% title("Portadora 1 Modulacion BFSK.")   %Ploteando la portadora 1
% ylabel("Amplitud (V)")
% xlabel("Tiempo (s)")
% grid on
% subplot(2,1,2)
% plot(t1,portadora2BFSK)
% xlim([0 0.000000005])
% title("Portadora 2 Modulacion BFSK.")   %Ploteando la portadora 2
% ylabel("Amplitud (V)")
% xlabel("Tiempo (s)")
% grid on
% 
% %Upsample a la senal de informacion
% 
% k = 1;
% for i = 1:length(bitstream)
%     for j =1:32
%         bitstream_UP(k) = bitstream(i);
%         k = k + 1;
%     end
% end
% figure(2)
% plot(bitstream_UP)
% title('Upsample de la informaci�n 2')
% axis([0 20*64 -0.5 1.5])
% 
% % % Modulacion 
% 
% j = 1;
% for i = 1:length(bitstream)
%     if bitstream(i) == 1
%         MODBFSK_bitstream(j:j+1000) = portadora1BFSK(1:1001);
%     end
%     if bitstream(i) == 0
%         MODBFSK_bitstream(j:j+1000) = portadora2BFSK(1:1001);
%     end
%     j = j + 1001;
% end
% figure(3)
% plot(MODBFSK_bitstream)
% title('Modulacion BFSK')
% xlabel('Tiempo (s)')
% ylabel('Amplitud (V)')
% axis([0 10000 -1.5 1.5])
% grid on
% % Espectro en frecuencia de la senal de informacion 1 modulada a BFSK.
% f_s = 1000e8;
% X = abs(fft(MODBFSK_bitstream));         % Transformada rapida de Fourier.
% m = length(MODBFSK_bitstream);                
% w = linspace(0,f_s,m)- f_s/2;
% figure(4)
% stem(w,abs(fftshift(fft(MODBFSK_bitstream))),'black')
% title('|X(w)|')
% xlabel('Frecuencia (Hz)')
% xlim([-3e9 3e9])

%% Modulación BPSK para la señal 

% Fs2 = 20e9;          %frecuencia de muestreo       
% T2 = 1/Fs2;            %periodo de muestreo
% t2 = 0:T2:0.000001;  %vector de tiempo
%  
% Ac=5;                  %Amplitud de la portadora
% %mc=4;                  %fc>>fs fc=mc*fs fs=1/Tb  fs=1GHz  
% fc=1e9;          %frecuencia del carrier 
% fase1=0;               %fase del carrier para bit 1
% fase2=pi;              %fase del carrier para bit 0
%                 
% t2L=length(t2);
% x_mod=[];
% for i=1:length(bitstream)
%     if (bitstream(i)==1)
%         x_mod0=Ac*cos(2*pi*fc*t2+fase1);    %modulation signal with carrier signal 1
%     else
%         x_mod0=Ac*cos(2*pi*fc*t2+fase2);    %modulation signal with carrier signal 2
%     end
%     x_mod=[x_mod x_mod0];
% end
% x_mod=transpose(x_mod);
% t2=1:length(x_mod);
% figure(1)
% plot(t2,x_mod)
% xlabel('Time(sec)');
% ylabel('Amplitude(volt)');
% title('Signal of  BASK modulation ');
% xlim([0 400])


%% 

% Upsample de la se�al.
k = 1;
datos = zeros(length(bitstream)*64,1);
for i = 1:length(bitstream)
    for j = 1:64
        datos(k) = bitstream(i);
        k = k + 1;
    end
end

t = linspace(0,1,length(datos));        %vector de tiempo
% fs = length(datos);                     %frecuencia de sampleo 64 KHz
A = 2;                                  %Amplitud de la señal
f = 10e6;                               %frecuencia del carrier
carrier = A*(cos(2*pi*f*t + pi/2) + 1i*sin(2*pi*f*t + pi/2));
figure(1)
plot(t,carrier)
axis([0 0.00003 -2.5 2.5])
title('Se�al de carrier')
xlabel('Tiempo (s)')
ylabel('Amplitud (V)')
y_BPSK1 = zeros(length(datos),1);
y_BPSK = zeros(length(datos),1);
s1 = A*(cos(2*pi*f*t + pi/2) + 1i*sin(2*pi*f*t + pi/2));
s2 = A*(cos(2*pi*f*t - pi/2) + 1i*sin(2*pi*f*t - pi/2));
s = [s1(1) s2(2)];
scatterplot(s)
figure(2)
plot(t,real(s1),t,real(s2))
title('Se�ales a utilizar')
xlabel('Tiempo (s)')
ylabel('Amplitud (V)')
    xlim([0 0.00005])
% Modulaci�n BPSK
for i = 1:length(datos)
    if datos(i) == 1
        y_BPSK(i) = s1(i);
    end
    if datos(i) == 0
        y_BPSK(i) = s2(i);
    end
end
figure(3)
plot(t,real(y_BPSK))
axis([0 0.01 -3 3])
title('Modulaci�n BPSK')
xlabel('Tiempo (s)')
ylabel('Amplitud (V)')
xlim([0 0.00003])
scatterplot(y_BPSK(1))
% BER BPSK
SNRdB = 0:1:15; %valores de SNR a medir.
SNR = 10.^(SNRdB/10); %SNR en escala decimal.
BER_sim = zeros(1,length(SNR)); %Vector donde calcularemos el BER.
datarec = zeros(length(bitstream),1);
Es = ((max(y).^2) + (min(y).^2))/2;
for i=1:length(SNR)
    %Canal
    doble_var_n = Es/SNR(i); %doble de la varianza de AWGN.
    channel = 1; %Asumimos que nuestro canal es ideal.
    n = randn(length(y_BPSK),1)*sqrt(doble_var_n/2);
    %Receptor
    MOD_REC = (y_BPSK.*channel) + n; % se�al*canal + ruido
    k = 1;
    for j = 1:64:length(MOD_REC)
        a(k) = phase(MOD_REC(j));
        if a(k) > 0
            datarec(k) = 1;
        else
            datarec(k) = 0;
        end
        k = k + 1;
    end
    error = sum(datarec~=bits);
    BER_sim(i) = error/length(datarec); %errores se van guardando en este vector, y se dividen entre el total de data transmitida.
end
figure(4)
semilogy(SNRdB,BER_sim,'*-') %plot semilogaritmico BER vs SNRdB
title('BER de Se�al transmitida')
xlabel('SNR(dB)')
ylabel('BER')
k = 1;
for i = 1:64:length(MOD_REC)
    b(k) = MOD_REC(i);
    k = k + 1;
end
scatterplot(b)




















