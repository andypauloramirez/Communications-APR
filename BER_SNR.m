clear all
clc

%Laboratorio de Sistemas de Comunicaciones - Andy Paulo Ramírez- - 1087586
%Práctica 4 :  BER Y SNR 

%% RELACION BER/SNR CON 4PAM (CON CÓDIG GRAY)

SNR =0:1:10;
SNRdecimal = 10.^(SNR/10);
BER = zeros(1, length(SNR));

% Transmisor 
signal= randi([0,1],1,10^6);    % generando un vector de bits aleatorios con l = 1000000

% Energía 
Ex = (9+1+1+9)/4;

for j=1:2:length(signal)

    if (signal(j)==0 && signal(j + 1)==0)          %00
        PAM((j+1)/2) = -3;
    end
    if (signal(j)==0 && signal(j + 1)==1)          %01
        PAM((j+1)/2) = -1;
    end
    if (signal(j)==1 && signal(j + 1)==1)          %11
        PAM((j+1)/2) = 1;
    end
    if (signal(j)==1 && signal(j + 1)==0)          %10
        PAM((j+1)/2) = 3;
    end
    L4 = length(PAM);

end

figure
stairs(PAM, 'r')
title('4PAM con Gray code');
xlim([1 15])
ylim([-4 4])

for i = 1:length(SNRdecimal)

        % Canal
        doble_var_n = Ex/SNRdecimal(i);
        channel = 1;                          
        n = randn(1,length(PAM))*sqrt(doble_var_n/2); % AWGN

        % Receptor
        Rx = (PAM.*channel) + n;                        % señal*canal + ruido

        % Decoding

   for t=1:L4
        if (Rx(t) > 2)
            Rx2(2*t - 1) = 1;
            Rx2(2*t) = 0;
        end
        if (Rx(t)<= 2 && Rx(t)>0)
            Rx2(2*t - 1) = 1;
            Rx2(2*t) = 1;
        end
        if (Rx(t) <= 0 && Rx(t) > -2)
            Rx2(2*t - 1) = 0;
            Rx2(2*t) = 1;
        end
        if (Rx(t) <= -2)
            Rx2(2*t - 1) = 0;
            Rx2(2*t) = 0;
        end
   end

 error = sum(Rx2~=signal);
 BER(i) = error/length(Rx2); % Medida del error de c/nivel
end

figure
semilogy(SNR,BER,'r *')    % BER vs SNR (semilog)
title('BER transmisión')
ylabel('BER')
xlabel('dB')

