%Comunicaciones Digitales
%Andy Paulo Ramirez-1087586 
%Julio Francisco Nuñez
%Proyecto final: Sistema de comunicaciones digitales para compañías
clc
clear all

%% Parte 1: Tomar una informacion (imagen) convertirla a un stream de bits (bitstream) 

filename = 'perro.jpeg';
img = imread(filename);
 if ndims(img) > 2
    imgray = rgb2gray(img);
 end
 
imgresized = imresize(imgray, [256 128]);

imbin = imbinarize(imgresized,'global');

bitstream1 = imbin';            %convierte en vector columna
bitstream1 = bitstream1(:);     
bitstream_info = bitstream1';   %convierte en vector fila

figure (1)
imshow(filename)
title('Imagen de informacion')
figure (2)
subplot(121), imshow(imgresized), title('Imagen Escala de grises reajustada')
subplot(122), imshow(imbin), title('Imagen binarizada')
figure(3)
stairs(bitstream_info)
title('Senal de Bits de informacion de la Imagen');
xlabel('Cantidad de muestras');
ylabel('Amplitud');
axis([0 10e02 -0.5 1.5])

senal_3 = de2bi(imgresized);
senal_3 = senal_3';
senal_3 = senal_3(:);
%prueba = bi2de (senal_3,'left-msb');