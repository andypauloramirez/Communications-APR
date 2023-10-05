%Lab. Comunicaciones Digitales 
%Luis Carlo 06/06/17
%Codigo Muestra: Generador de simbolos QPSK y muestra de 
%dcalculo SER.
%------------------------------------------------------------------------
clear all
%--------------------
%      Variables 
%--------------------

SNRdB = 0:1:20; %valores de SNR a medir.
SNR = 10.^(SNRdB/10); %SNR en escala decimal.
SER_sim = zeros(1,length(SNR)); %Vector donde calcularemos el SER.

%--------------------
%      Simulacion
%--------------------


for i = 1:length(SNR)
    error = 0;
    
    %Transmisor
    data = randi([0,1],1,10e5); % Bits de data aleatoria.
    const = [exp(1i*pi/4),exp(1i*3*pi/4),exp(-1i*pi/4),exp(-1i*3*pi/4)]; %Simbolos de la constelacion QPSK.
    %Modulacion QPSK
    Tx(data==0) = const(1);
    Tx(data==1) = const(2);
    Tx(data==2) = const(3);
    Tx(data==3) = const(4);
    threshold = [pi/2,-pi/2]; %thresholds de decision.
    Es = 1; %Energia de nuestros simbolos. Es igual para todos (magnitud del simbolo).
    
    %Canal
    var_n = Es/SNR(i); %varianza de AWGN.
    channel = 1; %Asumimos que nuestro canal es ideal.
    n=(randn(1,length(Tx))+1i*randn(1,length(Tx)))*sqrt(var_n/2);  %AWGN
    
    %Receptor
    Rx = (Tx.*channel) + n; % se�al*canal + ruido
    
    %Detector
    contador = 1;
    datarec = zeros(1,length(data));
    for contador = 1:length(Rx) %Detector toma decision y compara data enviada.
        if angle(Rx(contador)) > 0
            if angle(Rx(contador)) < threshold(1)
                datarec(contador) = 0;
            elseif angle(Rx(contador)) > threshold(1) 
                datarec(contador) = 1;
            end;
        else
            if angle(Rx(contador)) > threshold(2)
                datarec(contador) = 2;
            elseif angle(Rx(contador)) < threshold(2)
                datarec(contador) = 3;
            end;
        end;
        if datarec(contador) ~= data(contador)
        error = error + 1;
        end;
    end;
    
    SER_sim(i) = error/length(datarec); %errores se van guardando en este vector.
end;

%--------------------
%      Display
%--------------------

semilogy(SNRdB,SER_sim,'*r') %plot semilogaritmico SER vs SNRdB
title('SER de Se�al transmitida')
xlabel('SNR(dB)')
ylabel('SER')