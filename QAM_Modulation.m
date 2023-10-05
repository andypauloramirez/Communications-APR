clear all
clc

%Laboratorio de Comunicaciones Digitales - Andy Paulo Ramírez- - 1087586
%Práctica 1 :  Modulación AM y FM 

%% 

data = 10000; %Datos de Modulación
SNRdB= 1: 1: 12; %12dB de Ruido SNR= 10.^(SNRdB/10);

BER_sim= zeros(1, length(SNR)); 
qam1 = zeros(data, 1); 
DQAM = randi([0,7], data, 1);

%Modulando los símbolos en QAM 
for i = 1: length(DQAM)	
    if DQAM(i) == 0	
        qam1(i) =1+1i; 
    elseif DQAM(i) == 1 
        qam1(i) = 0+2i;	
    elseif DQAM(i) == 2		
        qam1(i)= -1+1i;	
    elseif DQAM(i)== 3	
        qam1(i) = -2+0i;
    elseif DQAM(i) == 4 
        qam1(i) = 1-1i;	
    elseif DQAM(i) == 5		
        qam1(i) = 2+0i;		
    elseif DQAM(i) == 6	
        qam1(i) = -1-1i; 
    elseif DQAM(i) == 7 
        qam1(i) = 0-2i;	
    end
end

scatterplot(qam1) 
title ('QAM Tipo Rombo Transmisión') 
grid on

Es= ((max(qam1).^2) + (min(qam1).^2))/2; 
rec = zeros(1, length(DQAM));
%BER 
for i = 1: length(SNR)		
    doble_var_n = Es/SNR(i);	
    n = randn(length(qam1), 1) + randn(length(qam1), 1).*1i;	
    recibido = qam1 + n * doble_var_n;
for j = 1: length(recibido)

    if (real(recibido(j)) > 0.5 && real(recibido(j)) < 1.5) && (imag(recibido(j)) > 0.5 && imag(recibido(j)) < 1.5)	
        rec(j) = 0;	
    elseif (real(recibido(j)) > -0.5 && real(recibido(j)) < 0.5) && (imag(recibido(j)) > 1.5)
        rec(j) = 1;	
    elseif (real(recibido(j)) > -1.5 && real(recibido(j)) < -0.5) && (imag(recibido(j)) > 0.5 && imag(recibido(j)) < 1.5)
        rec(j) = 2;	
    elseif real(recibido(j)) < -1.5 && (imag(recibido(j))> -1.5 && imag(recibido(j)) < 1.5)
        rec(j) = 3;	
    elseif (real(recibido(j)) > 0.5 && real(recibido(j)) < 1.5) && (imag(recibido(j)) > -1.5 && imag(recibido(j)) < -0.5)
        rec(j) = 4;
    elseif (real(recibido(j)) > 1.5) && (imag(recibido(j))> -0.5 && imag(recibido(j)) < 0.5)
        rec(j) = 5;	
    elseif (real(recibido(j)) > -1.5 && real(recibido(j)) < -0.5) && (imag(recibido(j)) > -1.5 && imag(recibido(j)) < -0.5)
        rec(j) = 6;
    else
        rec(j) = 7;
    end
end

error = sum(rec.' ~= DQAM); 
BER_sim(i) = error/length(DQAM);
end

figure(2) 
semilogy(SNRdB, BER_sim, '*-') 
title('BER QAM Tipo Rombo') 
xlabel('SNR(dB)') 
ylabel('BER') 
grid on 
scatterplot(recibido) 
title('QAM Tipo Rombo Recepción') 
grid on

qam2 = zeros(data, 1);
for i = 1: length(DQAM)	
    if DQAM(i) == 0

        qam2(i) = -2 + 1i; 
    elseif DQAM(i) == 1 
        qam2(i) = -1 + 1i; 
    elseif DQAM(i) == 2 
        qam2(i) = 2 + 1i; 
    elseif DQAM(i) == 3 
        qam2(i) = 1 + 1i; 
    elseif DQAM(i) == 4 
        qam2(i) = -2 - 1i;
    elseif DQAM(i) == 5 
        qam2(i) = -1 - 1i; 
    elseif DQAM(i) == 6 
        qam2(i) = 2 - 1i; 
    elseif DQAM(i) == 7
qam2(i) = 1 - 1i;	
    end
end

scatterplot(qam2) 
grid on
%BER
Es = ((max(qam2).^2) + (min(qam2).^2))/2;
error = 0;

for i = 1: length(SNR)	doble_var_n = Es/SNR(i);	
    n = randn(length(qam2), 1) + randn(length(qam2), 1).*1i; 
    recibido = qam2 + n*doble_var_n;
    
for j = 1: length(recibido)			
    if (real(recibido(j)) <-1.5) && (imag(recibido(j))> 0) rec(j) = 0;
    elseif (real(recibido(j)) >= -1.5 && real(recibido(j)) < 0) && (imag(recibido(j))> 0)	rec(j) = 1;
    elseif real(recibido(j)) >= 1.5 && (imag(recibido(j)) > 0)		rec(j) = 2;		
    elseif (real(recibido(j)) >= 0 && real(recibido(j)) < 1.5) && (imag(recibido(j))> 0)	rec(j) = 3;
    elseif (real(recibido(j)) <-1.5) && (imag(recibido(j)) <= 0)		rec(j) = 4;
    elseif (real(recibido(j)) >= -1.5 && real(recibido(j)) < 0) && imag(recibido(j)) <= 0 rec(j) = 5;
    elseif (real(recibido(j)) >= 0 && real(recibido(j)) < 1.5) && (imag(recibido(j)) <= 0) rec(j) = 7;	
    else
        rec(j) = 6;
    
    end
end

error = sum(rec.' ~= DQAM); BER_sim(i) = error/length(DQAM); 
end

figure(5) 
semilogy(SNRdB, BER_sim, '*-') 
title('BER QAM Rectangular transmitida') 
xlabel('SNR(dB)') 
ylabel('BER') 
grid on 
scatterplot(recibido) 
grid on

qam3 = zeros(data, 1);

for i = 1: length(DQAM)	
    if DQAM(i) == 0
        qam3(i) = -2 - 2i; 
    elseif DQAM(i) == 1 
        qam3(i) = -2 + 0i; 
    elseif DQAM(i) == 2 
        qam3(i) = 0 - 2i; 
    elseif DQAM(i) == 3 
        qam3(i) = -2 + 2i; 
    elseif DQAM(i) == 4 
        qam3(i) = 2 - 0i; 
    elseif DQAM(i) == 5 
        qam3(i) = 2 + 2i; 
    elseif DQAM(i) == 6 
        qam3(i) = 2 - 2i; 
    elseif DQAM(i) == 7 
        qam3(i) = 0 + 2i;	
    end
end

scatterplot(qam3) 
grid on

% BER
Es = ((max(qam3).^2) + (min(qam3).^2))/2;
error = 0;
for i = 1: length(SNR)	
    doble_var_n = Es/SNR(i);
    n = randn(length(qam3),1) + randn(length(qam3),1).*1i;	
    recibido = qam3 + n*doble_var_n;	
    for j = 1: length(recibido)
        if (real(recibido(j)) <= -1) && (imag(recibido(j))<= -1)	
            rec(j) = 0;		
        elseif (imag(recibido(j)) > -1 && imag(recibido(j)) < 1) && (real(recibido(j))<= -1)			
            rec(j) = 1;
        elseif (real(recibido(j)) > -1 && real(recibido(j)) < 1) && (imag(recibido(j)) <= -1) 
            rec(j) = 2;	
        elseif (real(recibido(j)) <= -1) && (imag(recibido(j)) >= 1)	
            rec(j) = 3;	
        elseif (real(recibido(j)) >= 1) && ((imag(recibido(j)) < 1) && (real(recibido(j))> -1))
            rec(j) = 4;
        elseif (real(recibido(j)) >= 1) && (imag(recibido(j)) >= 1) 
            rec(j) = 5;
        elseif (real(recibido(j)) >= 1) && (imag(recibido(j)) < -1) 
            rec(j) = 6;
        else
            rec(j) = 7;	
        end
    end
    
    error = sum(rec.' ~= DQAM); 
    BER_sim(i) = error/length(DQAM); 
end

figure(8) 
semilogy(SNRdB, BER_sim, '*-')
title('BER QAM Cuadrícula transmitida') 
xlabel('SNR(dB)')
ylabel('BER') 
grid on 
scatterplot(recibido) 
grid on


qam4 = zeros(data, 1);

for i = 1: length(DQAM) 
    if DQAM(i) == 0
        qam4(i) = -1 - 0i; 
    elseif DQAM(i) == 1 
        qam4(i) = -2 + 2i; 
    elseif DQAM(i) == 2 
        qam4(i) = -2 - 2i; 
    elseif DQAM(i) == 3 
        qam4(i) = 0 - 2i; 
    elseif DQAM(i) == 4 
        qam4(i) = 0 + 2i; 
    elseif DQAM(i) == 5 
        qam4(i) = 1 + 0i;
    elseif DQAM(i) == 6 
        qam4(i) = 2 + 2i; 
    elseif DQAM(i) == 7
        qam4(i) = 2 - 2i;	
    end
end

scatterplot(qam4)
grid on

% BER
Es = ((max(qam4).^2) + (min(qam4).^2))/2;

for i = 1: length(SNR)	doble_var_n = Es/SNR(i);	
    n = randn(length(qam4), 1) + randn(length(qam4), 1).*1i;
    recibido = qam4 + n*doble_var_n;
    
for j = 1: length(recibido)	
    if (real(recibido(j)) <= 0 && real(recibido(j)) > -1.5) && (imag(recibido(j))> -1.5 && imag(recibido(j)) < 1.5)	
        rec(j) = 0;	
    elseif (real(recibido(j)) <= -1.5) && (imag(recibido(j)) >= 1.5)		
        rec(j) = 1;		
    elseif (real(recibido(j)) <= -1.5) && (imag(recibido(j)) <= -1.5)			
        rec(j) = 2;			
    elseif (real(recibido(j)) > -1.5 && real(recibido(j)) < 1.5) && (imag(recibido(j)) < -1.5)	
        rec(j) = 3;	
    elseif (real(recibido(j)) > -1.5 && real(recibido(j)) < 1.5) && (imag(recibido(j)) > 1.5)		
        rec(j) = 4;	
    elseif (real(recibido(j)) > 0 && real(recibido(j)) < 1.5) && (imag(recibido(j))> -1.5 && imag(recibido(j)) < 1.5)	
        rec(j) = 5;	
    elseif (real(recibido(j)) > 1) && (imag(recibido(j)) >= 1.5)	
        rec(j) = 6;	
    else	rec(j) = 7;	
    end
end

error = sum(rec.' ~= DQAM);
BER_sim(i) = error/length(DQAM); 

end

figure(11) 
semilogy(SNRdB,BER_sim, '*-') 
title('BER QAM Tipo Estrella transmitida') 
xlabel('SNR(dB)') 
ylabel('BER') 
grid on 
scatterplot(recibido) 
grid on












