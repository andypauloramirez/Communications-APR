
clc
clear all
%Laboratorio de Sistemas de Comunicaciones - Andy Paulo Ramírez- - 1087586
%Práctica 6 : Código Convolucional

%% Generando vector de 3 bits aleatorios 

msg = randi([0,1],1,3);         %mensaje

% Para un diagrama trellis (3,1,2) codificación es:

k = 1;
n = 3;
reg = 2;
coderate = k/n;
m1=0;
m2=0;
convin = msg;

for i = 1:length(convin)
    
    min = convin(k);
    sum1 = bitxor(min,m1);
    n1 = bitxor(sum1,m2);

    sum2 = bitxor(m1,m2);
    n2 = sum2;
    
    sum3 = bitxor(min,m2);
    n3 = sum3;
 
    convout(3*k-2) = n1;
    convout(3*k-1) = n2;
    convout(3*k) = n3;
    
   m2=m1;
   m1=min;
  
end

%% Decodificacion 

trellis = poly2trellis(3,[6 7]);
codedmsg = convenc(msg,trellis);
tdepth = 2;
viterbi = vitdec(codedmsg,trellis,tdepth,'trunc','hard');

biterr(msg,viterbi)












