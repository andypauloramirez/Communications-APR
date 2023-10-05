
clc

%Laboratorio de Sistemas de Comunicaciones - Andy Paulo Ramírez- - 1087586
%Práctica 6 :   Codigo de Hamming (7,4)

%% Generando los 16 posibles mensajes de 4 bits

mensaje = [];                                %mensaje
ec = [];                                     %error corregido
S = [];                                      %sindrome
CM = [];    
P = [1 1 0; 1 0 1; 0 1 1; 1 1 1];            %matriz de paridad
H = [[1 1 0 1; 1 0 1 1; 0 1 1 1] eye(3)];    %matriz H

n = 7;
k = 4;
G = [eye(k) P];                              %Matriz generadora
data = randi([0,1], 1, 20);
convto4 = de2bi(0:15, 4, 'left-msb');        %Convirtiendo a 4 bits
hamming = encode (reshape (convto4', 1,[]), n, k, 'hamming/binary'); % Hamming gENERATOR
CodeW = reshape (hamming, 7, 16)';

BG = reshape(mod(convto4 * G, 2)', 1, []);

for r = 1:4:20 
    
    mensaje = [mensaje, mod(data(r:r + 3)* G, 2)];
end

mensaje; 

% Añadiendo error 

mensaje(4) = ~mensaje(4); 
mensaje (10) = ~mensaje(10); 
mensaje (18) = ~mensaje(18); 
mensaje (22) = ~mensaje(22); 
mensaje (31) = ~mensaje(31); 

errors = mensaje; 

for r = 1:n:(5*n) 
    
    S = [S, mod(mensaje(r:r +6) * H',2)]; 
end

S = reshape(S, 3, 5)'; 

% Factor de Corrección 

for y = 0:k 
    j = 0;
    w = 0; 
    for r = 1:n 
        if ~j 
            ver = zeros (1,n); 
            ver(r) = 1; 
            
            if mod(ver * H', 2) == S(y + 1, :)
                j = 1; 
                w = r; 
            end
        end
    end
    
    A = mensaje (y * 7 + 1: y * 7 + 7);
    C = A; 
    C(w) = mod(A(w) + 1, 2); 
    ec = [ec, C]; 
end

ec = reshape(ec, 7, 5)' 


for x = 1:5
    cnt = 0;
    for a16 = 1:7:112
        if ec(x, :) == BG(a16:a16 + 6)
            CM = [CM, de2bi(cnt, 4, 'left-msb')];
        end
        cnt = cnt + 1;
    end
    
end
