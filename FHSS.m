%% Proyecto Final de Comunicaciones Digitales
%
%% Inicio
clear
clc

%% Informacion de la compania 1
% Informacion 1.
Texto1 = importdata('texto4G.txt'); 
Texto1char = char(Texto1);
Texto1Double = double(Texto1char);

% Conversion de valores ASCII a valores binarios.
Texto1_bits = zeros(2e3,8);
Texto1_bits(1:length(de2bi(Texto1Double,'left-msb')),:) = de2bi(Texto1Double,'left-msb');
bitstream1 = Texto1_bits';
bitstream1 = bitstream1(:);
bitstream_info1 = bitstream1';
figure(1)
stairs(bitstream_info1)
title('Senal de Bits de informacion 1');
xlabel('Cantidad de muestras');
ylabel('Amplitud');
axis([3000 3100 -0.5 1.5])

%% Información 2 de la compañía 1
% Información 2.
Texto2 = importdata('texto2G.txt');
Texto2char = char(Texto2);
Texto2Double = double(Texto2char);
Texto2_bits = zeros(2e3,8);
% Conversión de valores ASCII a valores binarios.
Texto2_bits(1:length(de2bi(Texto2Double,'left-msb')),:) = de2bi(Texto2Double,'left-msb');
bitstream1 = Texto2_bits';
bitstream1 = bitstream1(:);
bitstream_info2 = bitstream1';
figure(2)
stairs(bitstream_info2)
title('Señal de Bits de información 2');
xlabel('Cantidad de muestras');
ylabel('Amplitud');
axis([3000 3100 -0.5 1.5])

%% Información de la compañía 2.
% Información 3.
Texto3 = importdata('texto3G.txt'); 
Texto3char = char(Texto3);
Texto3Double = double(Texto3char);
Texto3_bits = zeros(2e3,8);
% Conversión de valores ASCII a valores binarios.
Texto3_bits(1:length(de2bi(Texto3Double,'left-msb')),:) = de2bi(Texto3Double,'left-msb');
bitstream1 = Texto3_bits';
bitstream1 = bitstream1(:);
bitstream_info3 = bitstream1';
figure(3)
stairs(bitstream_info3)
title('Señal de Bits de información 3');
xlabel('Cantidad de muestras');
ylabel('Amplitud');
axis([3000 3100 -0.5 1.5])

% Información 4.
Texto4 = importdata('texto4G.txt'); 
Texto4char = char(Texto4);
Texto4Double = double(Texto4char);
Texto4_bits = zeros(2e3,8);
% Conversión de valores ASCII a valores binarios.
Texto4_bits(1:length(de2bi(Texto4Double,'left-msb')),:) = de2bi(Texto4Double,'left-msb');
bitstream1 = Texto4_bits';
bitstream1 = bitstream1(:);
bitstream_info4 = bitstream1';
figure(4)
stairs(bitstream_info4)
title('Señal de Bits de información 4');
xlabel('Cantidad de muestras');
ylabel('Amplitud');
axis([3000 3100 -0.5 1.5])

% Información 5.
Texto5 = importdata('texto1G.txt'); 
Texto5char = char(Texto5);
Texto5Double = double(Texto5char);
Texto5_bits = zeros(2e3,8);
% Conversión de valores ASCII a valores binarios.
Texto5_bits(1:length(de2bi(Texto5Double,'left-msb')),:) = de2bi(Texto5Double,'left-msb');
bitstream1 = Texto5_bits';
bitstream1 = bitstream1(:);
bitstream_info5 = bitstream1';
figure(5)
stairs(bitstream_info5)
title('Señal de Bits de información 5');
xlabel('Cantidad de muestras');
ylabel('Amplitud');
axis([3000 3100 -0.5 1.5])

%% Señal portadora para información 1 y 2 (Compañía 1)
Fs = 20e9;
T = 1/Fs;
t = 0:T:0.0000001;
f1 = 1.2e9;
f2 = 1.6e9;
f3 = 1.4e9;
f4 = 1.8e9;
y1_text1 = cos(2*pi*f1*t);
y2_text1 = cos(2*pi*f2*t);
y1_text2 = cos(2*pi*f3*t);
y2_text2 = cos(2*pi*f4*t);
figure(7)
subplot(2,2,1)
plot(t,y1_text1)
xlim([0 0.000000005])
title("Portadora 1 (info 1).")
ylabel("Amplitud (V)")
xlabel("Tiempo (s)")
grid on
subplot(2,2,2)
plot(t,y2_text1)
xlim([0 0.000000005])
title("Portadora 2 (info 1).")
ylabel("Amplitud (V)")
xlabel("Tiempo (s)")
grid on
subplot(2,2,3)
plot(t,y1_text2)
xlim([0 0.000000005])
title("Portadora 1 (info 2).")
ylabel("Amplitud (V)")
xlabel("Tiempo (s)")
grid on
subplot(2,2,4)
plot(t,y2_text2)
xlim([0 0.000000005])
title("Portadora 2 (info 2).")
ylabel("Amplitud (V)")
xlabel("Tiempo (s)")
grid on

%% Modulación BFSK de información 1.
j = 1;
for i = 1:length(bitstream_info1)
    if bitstream_info1(i) == 1
        MOD_Texto1(j:j+2000) = y1_text1(1:2001);
    end
    if bitstream_info1(i) == 0
        MOD_Texto1(j:j+2000) = y2_text1(1:2001);
    end
    j = j + 2001;
end
figure(8)
plot(MOD_Texto1)
title('Modulación BFSK información 1')
xlabel('Tiempo (s)')
ylabel('Amplitud (V)')
axis([3850 4100 -1.5 1.5])
grid on
%Gráfica del espectro de frecuencias
m = length(MOD_Texto1);
w = linspace(0,Fs,m)-Fs/2;
figure(9)
stem(w,abs(fftshift(fft(MOD_Texto1))),'black')
title('|X(w)|')
xlabel('Frecuencia (Hz)')
xlim([-3e9 3e9])

%% DSSS a información 1.
randSequence_txt1 = randi([0,1],length(MOD_Texto1)/8,1);
randSequence_txt1(randSequence_txt1==0) = -1;
k = 1;
for i = 1:length(MOD_Texto1)
    DSSS_txt1(i) = MOD_Texto1(i).*randSequence_txt1(k);
    if mod(i,8)==0
        k = k + 1;
    end
end

%Gráfica del espectro de frecuencias           
w1 = linspace(0,Fs,m)-Fs/2;
figure(10)
stem(w1,abs(fftshift(fft(DSSS_txt1))),'black')
title('|X(w)| (DSSS)')
xlabel('Frecuencia (Hz)')

%% BFSK información 2.
j = 1;
for i = 1:length(bitstream_info2)
    if bitstream_info2(i) == 1
        MOD_Texto2(j:j+2000) = y1_text2(1:2001);
    end
    if bitstream_info2(i) == 0
        MOD_Texto2(j:j+2000) = y2_text2(1:2001);
    end
    j = j + 2001;
end
figure(12)
plot(MOD_Texto2)
title('Modulación BFSK')
xlabel('Tiempo (s)')
ylabel('Amplitud (V)')
axis([0 10000 -1.5 1.5])
grid on
%Gráfica del espectro de frecuencias
m = length(MOD_Texto2);                
w2 = linspace(0,Fs,m)-Fs/2;
figure(13)
stem(w2,abs(fftshift(fft(MOD_Texto2))),'black')
title('|X(w)|')
xlabel('Frecuencia (Hz)')
xlim([-3e9 3e9])
%% DSSS información 2.
randSequence_txt2 = randi([0,1],length(MOD_Texto2)/8,1);
randSequence_txt2(randSequence_txt2==0) = -1;
k = 1;
for i = 1:length(MOD_Texto2)
    DSSS_txt2(i) = MOD_Texto2(i).*randSequence_txt2(k);
    if mod(i,8)==0
        k = k + 1;
    end
end
%Gráfica del espectro de frecuencias
m = length(DSSS_txt2);                
w = linspace(0,Fs,m)-Fs/2;
figure(14)
stem(w,abs(fftshift(fft(DSSS_txt2))),'black')
title('|X(w)| (DSSS)')
xlabel('Frecuencia (Hz)')

%% Señal portadora para información 3, 4 y 5 (Compañía 2)
Fs = 20e9;
T = 1/Fs;
t = 0:T:0.0000001;
f1_2 = 1.1e9;
f2_2 = 1.5e9;
f3_2 = 1.2e9;
f4_2= 1.6e9;
f5_2 = 1.3e9;
f6_2 = 1.7e9;
y1_text3 = cos(2*pi*f1_2*t);
y2_text3 = cos(2*pi*f2_2*t);
y1_text4 = cos(2*pi*f3_2*t);
y2_text4 = cos(2*pi*f4_2*t);
y1_text5 = cos(2*pi*f5_2*t);
y2_text5 = cos(2*pi*f6_2*t);
figure(15)
subplot(2,3,1)
plot(t,y1_text3)
xlim([0 0.000000005])
title("Portadora 1 (info 3).")
ylabel("Amplitud (V)")
xlabel("Tiempo (s)")
grid on
subplot(2,3,2)
plot(t,y2_text3)
xlim([0 0.000000005])
title("Portadora 2 (info 3).")
ylabel("Amplitud (V)")
xlabel("Tiempo (s)")
grid on
subplot(2,3,3)
plot(t,y1_text4)
xlim([0 0.000000005])
title("Portadora 3 (info 4).")
ylabel("Amplitud (V)")
xlabel("Tiempo (s)")
grid on
subplot(2,3,4)
plot(t,y2_text4)
xlim([0 0.000000005])
title("Portadora 4 (info 4).")
ylabel("Amplitud (V)")
xlabel("Tiempo (s)")
grid on
subplot(2,3,5)
plot(t,y1_text5)
xlim([0 0.000000005])
title("Portadora 5 (info 5).")
ylabel("Amplitud (V)")
xlabel("Tiempo (s)")
grid on
subplot(2,3,6)
plot(t,y2_text5)
xlim([0 0.000000005])
title("Portadora 6 (info 6).")
ylabel("Amplitud (V)")
xlabel("Tiempo (s)")
grid on

%% BFSK información 3.
j = 1;
for i = 1:length(bitstream_info3)
    if bitstream_info3(i) == 1
        MOD_Texto3(j:j+2000) = y1_text3(1:2001);
    end
    if bitstream_info3(i) == 0
        MOD_Texto3(j:j+2000) = y2_text3(1:2001);
    end
    j = j + 2001;
end
figure(17)
plot(MOD_Texto3)
title('Modulación BFSK información 3')
xlabel('Tiempo (s)')
ylabel('Amplitud (V)')
axis([0 10000 -1.5 1.5])
grid on
% Espectro en frecuencia de la señal de información 1 modulada a BFSK.
m = length(MOD_Texto3);                
w3 = linspace(0,Fs,m)-Fs/2;
figure(18)
stem(w3,abs(fftshift(fft(MOD_Texto3))),'black')
title('|X(w)|')
xlabel('Frecuencia (Hz)')
xlim([-3e9 3e9])

%% BFSK información 4.
j = 1;
for i = 1:length(bitstream_info4)
    if bitstream_info4(i) == 1
        MOD_Texto4(j:j+2000) = y1_text4(1:2001);
    end
    if bitstream_info4(i) == 0
        MOD_Texto4(j:j+2000) = y2_text4(1:2001);
    end
    j = j + 2001;
end
figure(20)
plot(MOD_Texto4)
title('Modulación BFSK información 4')
xlabel('Tiempo (s)')
ylabel('Amplitud (V)')
axis([0 10000 -1.5 1.5])
grid on
% Espectro en frecuencia de la señal de información 1 modulada a BFSK.
m = length(MOD_Texto4);                
w4 = linspace(0,Fs,m)-Fs/2;
figure(21)
stem(w4,abs(fftshift(fft(MOD_Texto4))),'black')
title('|X(w)|')
xlabel('Frecuencia (Hz)')
xlim([-3e9 3e9])

%% BFSK información 5.
j = 1;
for i = 1:length(bitstream_info5)
    if bitstream_info5(i) == 1
        MOD_Texto5(j:j+2000) = y1_text5(1:2001);
    end
    if bitstream_info5(i) == 0
        MOD_Texto5(j:j+2000) = y2_text5(1:2001);
    end
    j = j + 2001;
end
figure(23)
plot(MOD_Texto5)
title('Modulación BFSK información 5')
xlabel('Tiempo (s)')
ylabel('Amplitud (V)')
axis([0 10000 -1.5 1.5])
grid on
% Espectro en frecuencia de la señal de información 1 modulada a BFSK.
m = length(MOD_Texto5);                
w5 = linspace(0,Fs,m)-Fs/2;
figure(24)
stem(w5,abs(fftshift(fft(MOD_Texto5))),'black')
title('|X(w)|')
xlabel('Frecuencia (Hz)')
xlim([-3e9 3e9])
%% Señal en el canal
senal_por_el_canal = DSSS_txt1 + DSSS_txt2 + MOD_Texto3 + MOD_Texto4 + MOD_Texto5;
m = length(senal_por_el_canal);                
wt = linspace(0,Fs,m)-Fs/2;
figure(25)
stem(wt,abs(fftshift(fft(senal_por_el_canal))),'black')
title('|X(w)|')
xlabel('Frecuencia (Hz)')
xlim([-4e9 4e9])

%% Paso de las señales por el canal AWGN.

SNRdB = 15;
SNR = 10.^(SNRdB/10);
Es = ((max(senal_por_el_canal).^2) + (min(senal_por_el_canal).^2))/2;
doble_var_n = Es/SNR;

% Creación del canal AWGN.
AWGN = sqrt(doble_var_n/2).*randn(1,length(senal_por_el_canal));  %AWGN
m = length(AWGN);                
wr = linspace(0,Fs,m)-Fs/2;
figure(26)
stem(wr,abs(fftshift(fft(AWGN))),'black')
title('|Xr(w)|')
xlabel('Frecuencia (Hz)')

% Pasar la señal con las informaciones por el canal.
senal_rec = AWGN + senal_por_el_canal;
m = length(senal_rec);                
wc = linspace(0,Fs,m)-Fs/2;
figure(27)
stem(wc,abs(fftshift(fft(senal_rec))),'black')
title('|Xc(w)|')
xlabel('Frecuencia (Hz)')
xlim([-4e9 4e9])
%% Demodulación señal de información 1.
% Revirtiendo el efecto de DSSS.
k = 1;
for i = 1:length(senal_rec)
    info1(i) = senal_rec(i).*randSequence_txt1(k);
    if mod(i,8)==0
        k = k + 1;
    end
end
%Gráfica del espectro de frecuencias
m = length(info1);                
w_r1 = linspace(0,Fs,m)-Fs/2;
figure(28)
stem(w_r1,abs(fftshift(fft(info1))),'black')
title('|X(w)|')
xlabel('Frecuencia (Hz)')
xlim([-3e9 3e9])
figure(29)
plot(info1)
title('Modulación BFSK RECIBIDA')
xlabel('Tiempo (s)')
ylabel('Amplitud (V)')
axis([0 10000 -10 10])
grid on
% Demodulación de la señal
k = 1;
for i = 1:2001:length(info1)
    % Filtros correlacionadores.
    rec1(i:i+2000) = info1(i:i+2000).*y1_text1(1:2001);
    rec2(i:i+2000) = info1(i:i+2000).*y2_text1(1:2001);
    % Comparación de los valores
    if sum(rec1(i:i+2000)) > sum(rec2(i:i+2000))
        datarec_1(k) = 1;
    else
        datarec_1(k) = 0;
    end
    k = k + 1;
end
error = sum(datarec_1~=bitstream_info1)
figure(30)
stairs(datarec_1)
title('Señal de Bits recibida (Información 1)');
xlabel('Cantidad de muestras');
ylabel('Amplitud');
axis([0 100 -0.5 1.5])

%Reordenando bits recibidos
bits_recep1 = zeros(2e3,8);
k = 1;
for i = 1:length(bits_recep1)
    for j = 1:8
        bits_recep1(i,j) = datarec_1(k);
        k = k + 1;
    end
end

% Texto resultante.
senal_1 = bi2de(bits_recep1,'left-msb');
texto_1_recepcion = char(senal_1)'
%% Demodulación señal de información 2.
% Revirtiendo el efecto de DSSS
k = 1;
for i = 1:length(senal_rec)
    info2(i) = senal_rec(i).*randSequence_txt2(k);
    if mod(i,8)==0
        k = k + 1;
    end
end
%Gráfica del espectro de frecuencias
m = length(info2);                
w_r2 = linspace(0,Fs,m)-Fs/2;
figure(31)
stem(w_r2,abs(fftshift(fft(info2))),'black')
title('|X(w)|')
xlabel('Frecuencia (Hz)')
xlim([-3e9 3e9])
figure(32)
plot(info2)
title('Señal BFSK RECIBIDA')
xlabel('Tiempo (s)')
ylabel('Amplitud (V)')
axis([0 10000 -10 10])
grid on
% Demodulación de la señal
k = 1;
for i = 1:2001:length(info2)
    % Filtros correlacionadores
    rec3(i:i+2000) = info2(i:i+2000).*y1_text2(1:2001);
    rec4(i:i+2000) = info2(i:i+2000).*y2_text2(1:2001);
    % Comparación de los valores
    if sum(rec3(i:i+2000)) > sum(rec4(i:i+2000))
        datarec_2(k) = 1;
    else
        datarec_2(k) = 0;
    end
    k = k + 1;
end
error = sum(datarec_2~=bitstream_info2)
figure(33)
stairs(datarec_2)
title('Señal de Bits recibida (Información 2)');
xlabel('Cantidad de muestras');
ylabel('Amplitud');
axis([0 100 -0.5 1.5])

%Reordenando bits recibidos
bits_recep2 = zeros(2e3,8);
k = 1;
for i = 1:length(bits_recep2)
    for j = 1:8
        bits_recep2(i,j) = datarec_2(k);
        k = k + 1;
    end
end

% Texto resultante.
senal_2 = bi2de(bits_recep2,'left-msb');
texto_2_recepcion = char(senal_2)'
%% Demodulación señal de información 3.
% Demodulación de la señal
k = 1;
for i = 1:2001:length(senal_rec)
    % Filtros correlacionadores.
    rec5(i:i+2000) = senal_rec(i:i+2000).*y1_text3(1:2001);
    rec6(i:i+2000) = senal_rec(i:i+2000).*y2_text3(1:2001);
    % Comparación de los valores
    if sum(rec5(i:i+2000)) > sum(rec6(i:i+2000))
        datarec_3(k) = 1;
    else
        datarec_3(k) = 0;
    end
    k = k + 1;
end
error = sum(datarec_3~=bitstream_info3)
figure(34)
stairs(datarec_3)
title('Señal de Bits recibida (Información 3)');
xlabel('Cantidad de muestras');
ylabel('Amplitud');
axis([0 100 -0.5 1.5])

%Reordenando bits recibidos
bits_recep3 = zeros(2e3,8);
k = 1;
for i = 1:length(bits_recep3)
    for j = 1:8
        bits_recep3(i,j) = datarec_3(k);
        k = k + 1;
    end
end

% Texto resultante.
senal_3 = bi2de(bits_recep3,'left-msb');
texto_3_recepcion = char(senal_3)'
%% Demodulación señal de información 4.
k = 1;
for i = 1:2001:length(senal_rec)
    % filtros correlacionadores.
    rec7(i:i+2000) = senal_rec(i:i+2000).*y1_text4(1:2001);
    rec8(i:i+2000) = senal_rec(i:i+2000).*y2_text4(1:2001);
    % Comparación de los valores
    if sum(rec7(i:i+2000)) > sum(rec8(i:i+2000))
        datarec_4(k) = 1;
    else
        datarec_4(k) = 0;
    end
    k = k + 1;
end
error = sum(datarec_4~=bitstream_info4)
figure(35)
stairs(datarec_4)
title('Señal de Bits recibida (Información 4)');
xlabel('Cantidad de muestras');
ylabel('Amplitud');
axis([0 100 -0.5 1.5])

%Reordenando bits recibidos
bits_recep4 = zeros(2e3,8);
k = 1;
for i = 1:length(bits_recep4)
    for j = 1:8
        bits_recep4(i,j) = datarec_4(k);
        k = k + 1;
    end
end

% Texto resultante.
senal_4 = bi2de(bits_recep4,'left-msb');
texto_4_recepcion = char(senal_4)'
%% Demodulación señal de información 5.
k = 1;
for i = 1:2001:length(senal_rec)
    % Filtros correlacionadores.
    rec9(i:i+2000) = senal_rec(i:i+2000).*y1_text5(1:2001);
    rec10(i:i+2000) = senal_rec(i:i+2000).*y2_text5(1:2001);
    % Comparación de los valores
    if sum(rec9(i:i+2000)) > sum(rec10(i:i+2000))
        datarec_5(k) = 1;
    else
        datarec_5(k) = 0;
    end
    k = k + 1;
end
error = sum(datarec_5~=bitstream_info5)
figure(35)
stairs(datarec_5)
title('Señal de Bits recibida (Información 5)');
xlabel('Cantidad de muestras');
ylabel('Amplitud');
axis([0 100 -0.5 1.5])

%Reordenando bits recibidos
bits_recep5 = zeros(2e3,8);
k = 1;
for i = 1:length(bits_recep5)
    for j = 1:8
        bits_recep5(i,j) = datarec_5(k);
        k = k + 1;
    end
end

% Texto resultante.
senal_5 = bi2de(bits_recep5,'left-msb');
texto_5_recepcion = char(senal_5)'


