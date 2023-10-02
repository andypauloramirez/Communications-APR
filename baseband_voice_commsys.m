%% Primera etapa
clear all;

Fs  = 8000;       % Sampling frequency 8 kHz       
t   = (0:1/Fs:10); 

%Tono 7 DTMF
fh = 1209; 
fl = 852; 

t = [0:1/Fs:1];
S = 0.5*(sin(2*pi*fh*t)+ sin(2*pi*fl*t)); %atenuacion


%Señal en el Tiempo
figure (1) 
subplot (2,2,[1 3]);
plot (t,S); 
xlabel ('Tiempo');
title ('Tono #7');

%Señal en la frecuencia
w = linspace(0,Fs,length(S)) - Fs/2;
subplot (2,2,[2 4]);
m = abs(fftshift(fft(S)));
stem (w,m);
xlabel ('Frecuencia (Hz)');
ylabel ('|Tono DTMF No. "4"|');
title ('FFT Tono DTMF No. "4"');
%% Transmision

%t1 = [0:1/(8*Fs):time];

%Filtrado
lowpass(S,3999.9,Fs);


%PCM 256 niveles
SCO = S + 1; % Señal con Offset en 1 para centralizarla con valores positivos
figure (4)
subplot (2,2,[2 4]);
plot(t,SCO,'k');
xlabel ('Frecuencia (Hz)');
ylabel ('Amplitud');
title ('Tono #7 Filtrado con Offset');

% Play Audio
%sound (soff, Fs)

d=[];
dr=[];

% Discretización de la Amplitud con 8 bits
for i = SCO
    data = round((i*255)/2);  % Señal Discretizada
    d=[d, bitget(data,1),bitget(data,2),bitget(data,3),bitget(data,4),bitget(data,5),bitget(data,6),bitget(data,7),bitget(data,8)];      % Señal Discretizada Redondeada
    dr=[dr,data];
    %sdr = [sdr, de2bi(dataflow,'left-msb')];
    
end

 %figure(5)

 %subplot (2,2,[3 5]);
 %rs(t1,sdr,'g');
 %hold on;
 %stairs(t,sd,'m');
 %xlim ([0 0.02]);
 %xlabel ('Tiempo (s)');
 %ylabel ('Amplitud');
 %title ('PCM 256 niveles');
 
 %figure(6)
 %Espectro de Frecuencia 
 %w2 = linspace(0,Fs,length(sd)) - Fs/2;
 %m2 = abs(fftshift(fft(sd)));
 %subplot (2,2,[4 6]);
 %stem (w2, m2,'g');
 %xlim ([-1500 1500]);
 %xlabel ('Frecuencia (Hz)');
 %ylabel ('|PCM 256 niveles|');
 %title ('FFT PCM 256 niveles'); 

 %Aplicando AMI RZ
 
 for i = d
     if (i==1 && mod(A1,2)==0)
         A2 = [A2, -1, 0];
         A1 = A1 + 1;
     else if (i==1 && mod(A1,2)==1)
             A2 = [A2, 1, 0];
             A1 = A1 + 1;
         end
             
         end 
         
 end 

% figure (3)
% subplot (2,2,[1 3]);
% plot(t,ss,'green');
% xlabel ('Tiempo (segundos)');
% ylabel ('Amplitud');
% title ('Señal Codificada con Ruido'); 
% 
% ws = linspace(0,F,length(ss)) - F/2;
% mag_fft_ss = abs(fftshift(fft(ss)));
% subplot (2,2,[2 4]);
% stem (ws, mag_fft_ss,'green');
% xlabel ('Frecuencia (Hz)');
% ylabel ('|Señal Señal Codificada con Ruido(f)|');
% title ('FFT Señal Señal Codificada con Ruido');
%% AWGN


 r = 0.3*randn(1,length(t));      % Señal de Ruido
 
 % Suma de ambas señales
 ss = senalcodificada + r;    Suma de Señales
 figure (3)
 subplot (2,2,[1 3]);
 plot(t,ss,'green');
 xlabel ('Tiempo (segundos)');
 ylabel ('Amplitud');
 title ('Señal Codificada con Ruido'); 
 
 ws = linspace(0,F,length(ss)) - F/2;
 mag_fft_ss = abs(fftshift(fft(ss)));
 subplot (2,2,[2 4]);
 stem (ws, mag_fft_ss,'green');
 xlabel ('Frecuencia (Hz)');
 ylabel ('|Señal Señal Codificada con Ruido(f)|');
 title ('FFT Señal Señal Codificada con Ruido');