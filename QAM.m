%% Proyecto Final V2

%% Fuente de información 1
close all; clear; clc
%Tamaño de la información
max_c = 45e3;
scal = 0.08;
%Información 1
%Importamos la imagen
I = imread('GOT.jpg');
%Se le puede hacer un resize para reducir su tamaño (opcional)
I = imresize(I,scal);
figure
imshow(I)

%Variables con las dimensiones de la imagen
I_S1 = size(I,1);
I_S2 = size(I,2);

%3 matrices de dos dimensiones que conforman la imagen original de 3
%dimensiones
J_A = I(1:I_S1,1:I_S2,1);
J_B = I(1:I_S1,1:I_S2,2);
J_C = I(1:I_S1,1:I_S2,3);

%reordenando a un string de data las matrices J_A J_B y J_C
A = reshape(J_A,[],1);
B = reshape(J_B,[],1);
C = reshape(J_C,[],1);

%Concatenando verticalmente los strings de data A B y C
Z = zeros(max_c,1); %Se reserva a Z un tamaño máximo determinado
Z(1:length([A;B;C])) = [A;B;C];

%Se convierte el string Z que lleva toda la información de la imagen en un
%string de data en data binaria, convertida también en un string de 8 bits
%por entero en el vector Z. Se ordena de forma que el primer bit
%corresponde al más significativo del grupo de 8 bits.
BS_1 = int2bit(Z,8,1);  %String de data binaria a utilizar

%Concatenando 64 bits de información al final del string que llevan la
%información de la dimensión de la imagen al receptor.
%De esta forma se puede enviar imágenes de cualquier dimensión y el
%receptor sólo debe leer estos bits para recuperar la matriz en sus
%dimensiones originales
BS_1(length(BS_1)-63:length(BS_1)) = [int2bit(length(A),32,0);int2bit(I_S1,16,0);int2bit(I_S2,16,0)];
%BS_1 = [BS_1;int2bit(length(A),32);int2bit(I_S1,16,0);int2bit(I_S2,16,0)];

% Para más imágenes se puede seguir el mismo proceso. Se cambia el nombre
% del bitstream al final.

%% Fuente de información 2

I = imread('fox.jpg');
I = imresize(I,scal);
figure
imshow(I)

I_S1 = size(I,1);
I_S2 = size(I,2);

J_A = I(1:I_S1,1:I_S2,1);
J_B = I(1:I_S1,1:I_S2,2);
J_C = I(1:I_S1,1:I_S2,3);

A = reshape(J_A,[],1);
B = reshape(J_B,[],1);
C = reshape(J_C,[],1);

Z = zeros(max_c,1);
Z(1:length([A;B;C])) = [A;B;C];

BS_2= int2bit(Z,8,1);  %String de data binaria a utilizar
BS_2(length(BS_2)-63:length(BS_2)) = [int2bit(length(A),32,0);int2bit(I_S1,16,0);int2bit(I_S2,16,0)];
%BS_2 = [BS_2;int2bit(length(A),32);int2bit(I_S1,16,0);int2bit(I_S2,16,0)];

%% Fuente de información 3

I = imread('nauta.jpg');
I = imresize(I,scal);
figure
imshow(I)

I_S1 = size(I,1);
I_S2 = size(I,2);

J_A = I(1:I_S1,1:I_S2,1);
J_B = I(1:I_S1,1:I_S2,2);
J_C = I(1:I_S1,1:I_S2,3);

A = reshape(J_A,[],1);
B = reshape(J_B,[],1);
C = reshape(J_C,[],1);

Z = zeros(max_c,1);
Z(1:length([A;B;C])) = [A;B;C];

BS_3= int2bit(Z,8,1);  %String de data binaria a utilizar
BS_3(length(BS_3)-63:length(BS_3)) = [int2bit(length(A),32,0);int2bit(I_S1,16,0);int2bit(I_S2,16,0)];
%BS_3 = [BS_3;int2bit(length(A),32);int2bit(I_S1,16,0);int2bit(I_S2,16,0)];

%% Fuente de información 4

I = imread('uniman.jpg');
I = imresize(I,scal);
figure
imshow(I)

I_S1 = size(I,1);
I_S2 = size(I,2);

J_A = I(1:I_S1,1:I_S2,1);
J_B = I(1:I_S1,1:I_S2,2);
J_C = I(1:I_S1,1:I_S2,3);

A = reshape(J_A,[],1);
B = reshape(J_B,[],1);
C = reshape(J_C,[],1);

Z = zeros(max_c,1);
Z(1:length([A;B;C])) = [A;B;C];

BS_4 = int2bit(Z,8,1);  %String de data binaria a utilizar
BS_4(length(BS_4)-63:length(BS_4)) = [int2bit(length(A),32,0);int2bit(I_S1,16,0);int2bit(I_S2,16,0)];
%BS_4 = [BS_4;int2bit(length(A),32);int2bit(I_S1,16,0);int2bit(I_S2,16,0)];

%% Modulación 8-QAM de todas las informaciones
% Se concatena la información del stream de bits de cada usuario en 4
% columnas. Cada columna corresponde a un usuario, y cada columna tiene
% una cantidad de filas equivalente a la información que se puede enviar
% en la cantidad de tiempo asignada a cada usuario.

BS_T = [BS_1,BS_2,BS_3,BS_4];

% Cuando p=1 corresponde a la modulacion para la imagen 1, y asi
% sucesivamente
for p=1:size(BS_T,2)
    k = 1;
    for i=1:3:size(BS_T,1)
        if BS_T(i,p) == 0 && BS_T(i+1,p) == 0 && BS_T(i+2,p) == 0
            Mod_BS(k,p) = -2 - 2i;
        elseif BS_T(i,p) == 0 && BS_T(i+1,p) == 0 && BS_T(i+2,p) == 1
            Mod_BS(k,p) = -2 + 0i;
        elseif BS_T(i,p) == 0 && BS_T(i+1,p) == 1 && BS_T(i+2,p) == 0
            Mod_BS(k,p) = 0 - 2i;
        elseif BS_T(i,p) == 0 && BS_T(i+1,p) == 1 && BS_T(i+2,p) == 1
            Mod_BS(k,p) = -2 + 2i;
        elseif BS_T(i,p) == 1 && BS_T(i+1,p)== 0 && BS_T(i+2,p) == 0
            Mod_BS(k,p) = 2 - 0i;
        elseif BS_T(i,p) == 1 && BS_T(i+1,p) == 0 && BS_T(i+2,p) == 1
            Mod_BS(k,p) = 2 + 2i;
        elseif BS_T(i,p) == 1 && BS_T(i+1,p) == 1 && BS_T(i+2,p) == 0
            Mod_BS(k,p) = 2 - 2i;
        elseif BS_T(i,p) == 1 && BS_T(i+1,p) == 1 && BS_T(i+2,p) == 1
            Mod_BS(k,p) = 0 + 2i;
        end
        k = k + 1;
    end
    scatterplot(Mod_BS(:,p))
end

%% Creando símbolos a usar
% Creando señales para usar en el canal seleccionado

Fca = 7435e6;
Fcb = 7449e6;

Fs = 5e11; %frecuencia de muestreo
t = 0:1/Fs:1e-9;

%Encontrando las diferentes fases que forman la constelación
pc1=atan2(-2,-2);
pc2=atan2(0,-2);
pc3=atan2(-2,0);
pc4=atan2(2,-2);

pc5=atan2(0,2);
pc6=atan2(2,2);
pc7=atan2(-2,2);
pc8=atan2(2,0);

ph_r = [pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8]; %Fases en radianes
ph_d = rad2deg([pc1 pc2 pc3 pc4 pc5 pc6 pc7 pc8]) %Fases e grados

%Generando símbolos
A1 = 2; %Amplitud 1 de símbolos en las constelación
A2 = 2*sqrt(2); %Amplitud 2 de símbolos en las constelación

S1a = A2*cos(2*pi*Fca*t + pc1);
S1b = A2*sin(2*pi*Fcb*t + pc1);
Ph_S1 = atan2(S1b,S1a)';

S2a = A1*cos(2*pi*Fca*t + pc2);
S2b = A1*sin(2*pi*Fcb*t + pc2);
Ph_S2 = atan2(S2b,S2a)';

S3a = A1*cos(2*pi*Fca*t + pc3);
S3b = A1*sin(2*pi*Fcb*t + pc3);
Ph_S3 = atan2(S3b,S3a)';

S4a = A2*cos(2*pi*Fca*t + pc4);
S4b = A2*sin(2*pi*Fcb*t + pc4);
Ph_S4 = atan2(S4b,S4a)';

S5a = A1*cos(2*pi*Fca*t + pc5);
S5b = A1*sin(2*pi*Fcb*t + pc5);
Ph_S5 = atan2(S5b,S5a)';

S6a = A2*cos(2*pi*Fca*t + pc6);
S6b = A2*sin(2*pi*Fcb*t + pc6);
Ph_S6 = atan2(S6b,S6a)';

S7a = A2*cos(2*pi*Fca*t + pc7);
S7b = A2*sin(2*pi*Fcb*t + pc7);
Ph_S7 = atan2(S7b,S7a)';

S8a = A1*cos(2*pi*Fca*t + pc8);
S8b = A1*sin(2*pi*Fcb*t + pc8);
Ph_S8 = atan2(S8b,S8a)';

%% Modulación son símbolos de señales sinusoidales en frecuencia

% Tiempo total disponible por frame
m = (((max_c*8)/3)*501*4)*(1/Fs);
% Vector de tiempo por frame
tc = 0:1/Fs:m-1/Fs;
% Tamaño de slot por cada usuario
t_u = length(tc)/4;

% Bucle donde se modula a QAM y asigno cada columna de BS_T un slot en el
% tiempo (de 1 a 4 en orden los usuarios). Primero se modula la información
% del usuario 1 y se coloca las señales a enviar en el tiempo en los
% vectores BSC_a y BSC_b. Luego se modula la columna correspondiente al
% stream de bits de información del usuario dos y las señales generadas en
% el tiempo se concatenan al lado de de las del usuario uno. Y así
% sucesivamente, hasta generar una señal de tiempo m que se envía a través
% del canal. Si los usuarios siguen enviando información este esquema se
% repite en bucle.

j = 1;
for p=1:4
    for i=1:3:size(BS_T,1)
        if BS_T(i,p) == 0 && BS_T(i+1,p) == 0 && BS_T(i+2,p) == 0
            BSC_a(j:j+500) = S1a;
            BSC_b(j:j+500) = S1b;
        elseif BS_T(i,p) == 0 && BS_T(i+1,p) == 0 && BS_T(i+2,p) == 1
            BSC_a(j:j+500) = S2a;
            BSC_b(j:j+500) = S2b;
        elseif BS_T(i,p) == 0 && BS_T(i+1,p) == 1 && BS_T(i+2,p) == 0
            BSC_a(j:j+500) = S3a;
            BSC_b(j:j+500) = S3b;
        elseif BS_T(i,p) == 0 && BS_T(i+1,p) == 1 && BS_T(i+2,p) == 1
            BSC_a(j:j+500) = S4a;
            BSC_b(j:j+500) = S4b;
        elseif BS_T(i,p) == 1 && BS_T(i+1,p)== 0 && BS_T(i+2,p) == 0
            BSC_a(j:j+500) = S5a;
            BSC_b(j:j+500) = S5b;
        elseif BS_T(i,p) == 1 && BS_T(i+1,p) == 0 && BS_T(i+2,p) == 1
            BSC_a(j:j+500) = S6a;
            BSC_b(j:j+500) = S6b;
        elseif BS_T(i,p) == 1 && BS_T(i+1,p) == 1 && BS_T(i+2,p) == 0
            BSC_a(j:j+500) = S7a;
            BSC_b(j:j+500) = S7b;
        elseif BS_T(i,p) == 1 && BS_T(i+1,p) == 1 && BS_T(i+2,p) == 1
            BSC_a(j:j+500) = S8a;
            BSC_b(j:j+500) = S8b;
        end
        j = j + 501;
    end
end
BSC_a = BSC_a';
BSC_b = BSC_b';
%Con esto tenemos dos sub canales, uno enviando la señal de coseno y otro
%la de seno de la modulación 8-QAM con las informaciones de los 4 usuarios.

%% Gráfica en el tiempo y espectro
%%Canal 1a
figure
g = BSC_a(1:10e3);
plot(g)
title('Señal coseno de la modulación 8-QAM')
xlabel('Tiempo (s)')
ylabel('Amplitud (V)')
xlim([3e3 9e3])
grid on

le1 = length(g);
wr = linspace(0,Fs,le1)-Fs/2;
figure
stem(wr,abs(fftshift(fft(g))),'black')
title('|Xr(w)|')
xlabel('Frecuencia (Hz)')
xlim([-12e9 12e9])

%Canal 1b
g1 = BSC_b(1:10e3);
figure
plot(g1)
title('Señal seno de la modulación 8-QAM')
xlabel('Tiempo (s)')
ylabel('Amplitud (V)')
xlim([3e3 9e3])
grid on

le1 = length(g1);
wr = linspace(0,Fs,le1)-Fs/2;
figure
stem(wr,abs(fftshift(fft(g1))),'black')
title('|Xr(w)|')
xlabel('Frecuencia (Hz)')
xlim([-12e9 12e9])

%% Energía de símbolo y vector SNR
% S = [-2-2i -2+0i 0-2i -2+2i 2-0i 2+2i 2-2i 0+2i]; % Símbolos
% S = abs(S).^2;
%Es = (1/8)*(sum(S)); %Energía de símbolo

Es = (sum((A1^2)*4)+sum((A2^2)*4))/8; %Energía de símbolo
SNRdB = (-2:1:8)'; %valores de SNR a medir.
SNR = 10.^(SNRdB/10); %SNR en escala decimal.
BER_sim = zeros(length(SNR),1); %Vector donde calcularemos el BER.

%% Demodulación de la señal 8-QAM
for u=1:1:length(SNR)

    doble_var_n = Es/SNR(u);
    AWGN = sqrt(doble_var_n/2).*randn(length(BSC_a),1);  %AWGN
    BSC_an = BSC_a + AWGN;
    BSC_bn = BSC_b + AWGN;

    % Se toma el análisis de los fasores en cada punto de la señal recibida
    Ph_string = atan2(BSC_bn,BSC_an);

    %Se ejecuta un bucle para demodular el string de bits completos
    datarec_1 = 0;
    j = 1;
    for i = 1:501:length(Ph_string)
        % Filtros correlacionadores. Correlacionan el fragmento de señal
        % analizado en el periodo de símbolo con todos los posibles símbolos.
        rec1_a = Ph_string(i:i+500).*Ph_S1;
        rec1_b = Ph_string(i:i+500).*Ph_S2;
        rec1_c = Ph_string(i:i+500).*Ph_S3;
        rec1_d = Ph_string(i:i+500).*Ph_S4;
        rec1_e = Ph_string(i:i+500).*Ph_S5;
        rec1_f = Ph_string(i:i+500).*Ph_S6;
        rec1_g = Ph_string(i:i+500).*Ph_S7;
        rec1_h = Ph_string(i:i+500).*Ph_S8;

        % Se suman los valores correlacionados, la suma que sea más grande
        % corresponde al símbolo más probable.

        rec1_vec = [sum(rec1_a) sum(rec1_b) sum(rec1_c) sum(rec1_d) sum(rec1_e) sum(rec1_f) sum(rec1_g) sum(rec1_h)];
        for k=1:8
            if rec1_vec(1) == max(rec1_vec)
                datarec_1(j:j+2) = [0 0 0];
            elseif rec1_vec(2) == max(rec1_vec)
                datarec_1(j:j+2) = [0 0 1];
            elseif rec1_vec(3) == max(rec1_vec)
                datarec_1(j:j+2) = [0 1 0];
            elseif rec1_vec(4) == max(rec1_vec)
                datarec_1(j:j+2) = [0 1 1];
            elseif rec1_vec(5) == max(rec1_vec)
                datarec_1(j:j+2) = [1 0 0];
            elseif rec1_vec(6) == max(rec1_vec)
                datarec_1(j:j+2) = [1 0 1];
            elseif rec1_vec(7) == max(rec1_vec)
                datarec_1(j:j+2) = [1 1 0];
            elseif rec1_vec(8) == max(rec1_vec)
                datarec_1(j:j+2) = [1 1 1];
            end
        end
        j = j+3;
    end

    % Asignando la data a un vector para cada usuario según su asignación en TDM
    datarec_1 = datarec_1';
    datarec_1 = reshape(datarec_1,[],4); %BS_T recuperado

    % Capturando datos para BER - SNR
    error = sum(reshape(datarec_1~=BS_T,[],1))
    BER_sim(u) = error/(length(BS_T)*4);

end

% Grafica BER - SNR
figure
% Para que agregue los valores de 0 errores, le incluimos una amplitud muy
% baja para que aparezcan en la gráfica
BER_sim(BER_sim==0) = 10e-10;
semilogy(SNRdB,BER_sim,'*-') %plot semilogaritmico BER vs SNRdB
title('BER - SNR de Señal transmitida')
xlabel('SNR(dB)')
ylabel('BER')
grid on

%% Asignando data de llegada a cada usuario según su time slot asignado
BS_1R = datarec_1(:,1);
BS_2R = datarec_1(:,2);
BS_3R = datarec_1(:,3);
BS_4R = datarec_1(:,4);
%close all

%% Recuperando imagen 1 a partir de string de bits recibidos

%Tamaño de los vectores de string de data correspondiente a las matrices de
%dos dimensiones de la imagen original (variables A, B y C).
ABR_S = BS_1R(length(BS_1R)-63:length(BS_1R)-32);
%Tamaño de la dimensión 1 en la imagen original.
IBR_S1 = BS_1R(length(BS_1R)-31:length(BS_1R)-16);
%Tamaño de la dimensión 2 en la imagen original.
IBR_S2 = BS_1R(length(BS_1R)-15:length(BS_1R));

%Convirtiendo a decimales las variables con la información de las
%dimensiones descritas anteriormente.
IR_S1 = bit2int(IBR_S1,16,0);
IR_S2 = bit2int(IBR_S2,16,0);
AR_S = bit2int(ABR_S,32,0);

%Elimino los 64 bits de información concatenada del string de bits de la
%imagen.
%BS_1 = BS_1(1:length(BS_1)-64);

%Convierto en enteros el string de bits de la imagen. En paquetes de 8 bits
%para que corresponda con los paquetes creados al convertirlos en binario.
BS_1R = bit2int(BS_1R,8,1);

%Se redimensiona el string de bits para que forme una matriz de AR_S x 3
%Siendo AR_S el tamaño de los tres vectores A B y C que concatenamos en Z
%originalmente. D eesta forma recuperamos A, B y C en cada una de las tres
%columnas, respectivamente.
BS_1R = BS_1R(1:AR_S*3);
BS_1R = reshape(BS_1R,AR_S,[]);

%Acá se divide la matriz de AR_S x 3 en tres vectores de una dimensión
%distintos.
R_A = BS_1R(:,1);
R_B = BS_1R(:,2);
R_C = BS_1R(:,3);

%Cada uno de estos vectores se redimensiona con las dimensiones originales
%de la imagen enviada (información que recuperamos del string de bits
%enviado), de forma que recuperamos las variables que en el emisor se
%denominan J_A, J_B y J_C.
JR_A = uint8(reshape(R_A,IR_S1,IR_S2));
JR_B = uint8(reshape(R_B,IR_S1,IR_S2));
JR_C = uint8(reshape(R_C,IR_S1,IR_S2));

%Con la información obtenida en el paso anterior, ya tenemos 3 matrices de
%dos dimensiones de la imagen enviada. Ahora concatenamos estas 3 matrices
%en la tercera dimensión y mostramos la imagen, para comprobar que la
%imagen enviada fue la recibida.

K = cat(3,JR_A,JR_B,JR_C);
figure
imshow(K)

%% Recuperando imagen 2 a partir de string de bits recibidos

%Tamaño de los vectores de string de data correspondiente a las matrices de
%dos dimensiones de la imagen original (variables A, B y C).
ABR_S = BS_2R(length(BS_2R)-63:length(BS_2R)-32);
%Tamaño de la dimensión 1 en la imagen original.
IBR_S1 = BS_2R(length(BS_2R)-31:length(BS_2R)-16);
%Tamaño de la dimensión 2 en la imagen original.
IBR_S2 = BS_2R(length(BS_2R)-15:length(BS_2R));

%Convirtiendo a decimales las variables con la información de las
%dimensiones descritas anteriormente.
IR_S1 = bit2int(IBR_S1,16,0);
IR_S2 = bit2int(IBR_S2,16,0);
AR_S = bit2int(ABR_S,32,0);

%Elimino los 64 bits de información concatenada del string de bits de la
%imagen.
%BS_1 = BS_1(1:length(BS_1)-64);

%Convierto en enteros el string de bits de la imagen. En paquetes de 8 bits
%para que corresponda con los paquetes creados al convertirlos en binario.
BS_2R = bit2int(BS_2R,8,1);

%Se redimensiona el string de bits para que forme una matriz de AR_S x 3
%Siendo AR_S el tamaño de los tres vectores A B y C que concatenamos en Z
%originalmente. D eesta forma recuperamos A, B y C en cada una de las tres
%columnas, respectivamente.
BS_2R = BS_2R(1:AR_S*3);
BS_2R = reshape(BS_2R,AR_S,[]);

%Acá se divide la matriz de AR_S x 3 en tres vectores de una dimensión
%distintos.
R_A = BS_2R(:,1);
R_B = BS_2R(:,2);
R_C = BS_2R(:,3);

%Cada uno de estos vectores se redimensiona con las dimensiones originales
%de la imagen enviada (información que recuperamos del string de bits
%enviado), de forma que recuperamos las variables que en el emisor se
%denominan J_A, J_B y J_C.
JR_A = uint8(reshape(R_A,IR_S1,IR_S2));
JR_B = uint8(reshape(R_B,IR_S1,IR_S2));
JR_C = uint8(reshape(R_C,IR_S1,IR_S2));

%Con la información obtenida en el paso anterior, ya tenemos 3 matrices de
%dos dimensiones de la imagen enviada. Ahora concatenamos estas 3 matrices
%en la tercera dimensión y mostramos la imagen, para comprobar que la
%imagen enviada fue la recibida.

K = cat(3,JR_A,JR_B,JR_C);
figure
imshow(K)

%% Recuperando imagen 3 a partir de string de bits recibidos

%Tamaño de los vectores de string de data correspondiente a las matrices de
%dos dimensiones de la imagen original (variables A, B y C).
ABR_S = BS_3R(length(BS_3R)-63:length(BS_3R)-32);
%Tamaño de la dimensión 1 en la imagen original.
IBR_S1 = BS_3R(length(BS_3R)-31:length(BS_3R)-16);
%Tamaño de la dimensión 2 en la imagen original.
IBR_S2 = BS_3R(length(BS_3R)-15:length(BS_3R));

%Convirtiendo a decimales las variables con la información de las
%dimensiones descritas anteriormente.
IR_S1 = bit2int(IBR_S1,16,0);
IR_S2 = bit2int(IBR_S2,16,0);
AR_S = bit2int(ABR_S,32,0);

%Elimino los 64 bits de información concatenada del string de bits de la
%imagen.
%BS_1 = BS_1(1:length(BS_1)-64);

%Convierto en enteros el string de bits de la imagen. En paquetes de 8 bits
%para que corresponda con los paquetes creados al convertirlos en binario.
BS_3R = bit2int(BS_3R,8,1);

%Se redimensiona el string de bits para que forme una matriz de AR_S x 3
%Siendo AR_S el tamaño de los tres vectores A B y C que concatenamos en Z
%originalmente. D eesta forma recuperamos A, B y C en cada una de las tres
%columnas, respectivamente.
BS_3R = BS_3R(1:AR_S*3);
BS_3R = reshape(BS_3R,AR_S,[]);

%Acá se divide la matriz de AR_S x 3 en tres vectores de una dimensión
%distintos.
R_A = BS_3R(:,1);
R_B = BS_3R(:,2);
R_C = BS_3R(:,3);

%Cada uno de estos vectores se redimensiona con las dimensiones originales
%de la imagen enviada (información que recuperamos del string de bits
%enviado), de forma que recuperamos las variables que en el emisor se
%denominan J_A, J_B y J_C.
JR_A = uint8(reshape(R_A,IR_S1,IR_S2));
JR_B = uint8(reshape(R_B,IR_S1,IR_S2));
JR_C = uint8(reshape(R_C,IR_S1,IR_S2));

%Con la información obtenida en el paso anterior, ya tenemos 3 matrices de
%dos dimensiones de la imagen enviada. Ahora concatenamos estas 3 matrices
%en la tercera dimensión y mostramos la imagen, para comprobar que la
%imagen enviada fue la recibida.

K = cat(3,JR_A,JR_B,JR_C);
figure
imshow(K)

%% Recuperando imagen 4 a partir de string de bits recibidos

%Tamaño de los vectores de string de data correspondiente a las matrices de
%dos dimensiones de la imagen original (variables A, B y C).
ABR_S = BS_4R(length(BS_4R)-63:length(BS_4R)-32);
%Tamaño de la dimensión 1 en la imagen original.
IBR_S1 = BS_4R(length(BS_4R)-31:length(BS_4R)-16);
%Tamaño de la dimensión 2 en la imagen original.
IBR_S2 = BS_4R(length(BS_4R)-15:length(BS_4R));

%Convirtiendo a decimales las variables con la información de las
%dimensiones descritas anteriormente.
IR_S1 = bit2int(IBR_S1,16,0);
IR_S2 = bit2int(IBR_S2,16,0);
AR_S = bit2int(ABR_S,32,0);

%Elimino los 64 bits de información concatenada del string de bits de la
%imagen.
%BS_1 = BS_1(1:length(BS_1)-64);

%Convierto en enteros el string de bits de la imagen. En paquetes de 8 bits
%para que corresponda con los paquetes creados al convertirlos en binario.
BS_4R = bit2int(BS_4R,8,1);

%Se redimensiona el string de bits para que forme una matriz de AR_S x 3
%Siendo AR_S el tamaño de los tres vectores A B y C que concatenamos en Z
%originalmente. D eesta forma recuperamos A, B y C en cada una de las tres
%columnas, respectivamente.
BS_4R = BS_4R(1:AR_S*3);
BS_4R = reshape(BS_4R,AR_S,[]);

%Acá se divide la matriz de AR_S x 3 en tres vectores de una dimensión
%distintos.
R_A = BS_4R(:,1);
R_B = BS_4R(:,2);
R_C = BS_4R(:,3);

%Cada uno de estos vectores se redimensiona con las dimensiones originales
%de la imagen enviada (información que recuperamos del string de bits
%enviado), de forma que recuperamos las variables que en el emisor se
%denominan J_A, J_B y J_C.
JR_A = uint8(reshape(R_A,IR_S1,IR_S2));
JR_B = uint8(reshape(R_B,IR_S1,IR_S2));
JR_C = uint8(reshape(R_C,IR_S1,IR_S2));

%Con la información obtenida en el paso anterior, ya tenemos 3 matrices de
%dos dimensiones de la imagen enviada. Ahora concatenamos estas 3 matrices
%en la tercera dimensión y mostramos la imagen, para comprobar que la
%imagen enviada fue la recibida.

K = cat(3,JR_A,JR_B,JR_C);
figure
imshow(K)










