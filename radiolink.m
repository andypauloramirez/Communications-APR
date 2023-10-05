%Laboratorio de Transmision de senales RF
%Practica perfil de paso MATLAB
%Andy Paulo Ramirez - 1087586 

close all
clear all
clc

%% Programa que calcula el perfil de paso de un enlace de radio

%Asegurando que las latitudes escogidas coincidan con el mapa

lat1 = 19.4125;
lon1 = -70.6577777;
lat2 = 19.4986111;
lon2 = -70.6577777;
figure(1)
geoplot([lat1 lat2],[lon1 lon2],'blue-*')  
geolimits([20 20],[-75 -75])
geobasemap streets

latitud = [19.4125 19.4986111];                                     %limites de latitud
longitud = [-70.6577777 -70.65777777];                              %limites de longitud

mapa  = readgeoraster('RD_SRTMGL3.tif','OutputType','double');
[Z,R] = readgeoraster('RD_SRTMGL3.tif','OutputType','double');      %Leyendo archivo .tif del mapa 

[vis,visprofile,dist,h,lati,longi] = los2(Z,R,lat1,lon1,lat2,lon2); %Obteniendo valores 

distkm = dist/1000;                         %Convirtiendo de m a km  
dist_enlace = 10;
distance = linspace(0,dist_enlace,length(distkm));
figure(2) 
plot(distance,h,'blue');
title('Perfil de paso');
xlabel('Distancia del perfil (km)');
ylabel('Altura de cada punto (m)');
ylim([190 300])

%Calculo de la curvatura de la tierra 
frecuencia_GHz = 6;                         %Frecuencia del enlace
K = 1.33;                                   %Constante curvatura de la tierra

for i = 1: length(distance)
    curvatura(i) = 0.078*(distance(i).*(dist_enlace - distance(i)))/K;
end
hfresnel = 10 ;                             %10m fresnel
vegetacion = 15;                            %15m vegetacion
hcalculado = hfresnel + vegetacion + h;     % h = valores de altura dadas por el comando readgeoraster
hcalculado = hcalculado.';                  %Reajustando la matriz para la operación
hreal = hcalculado + curvatura;             %Altura total tomando en cuenta todas las variables

%Calculo de la zona de fresnel en cada punto

for i = 1:length(hreal) 
    Fresnel(i) = 17.3*sqrt((distance(i)*(dist_enlace-distance(i)))/(frecuencia_GHz*dist_enlace));
end
antena1 = 10;                               %Estimacion tamaño inicial de la antena 1
antena2 = 10;                               %Estimacion tamaño inicial de la antena 2

Fresnel_Y = linspace(hreal(1)+antena1,hreal(end)+antena1,length(hreal));

Radio_inf = Fresnel_Y - Fresnel;            % Radio de fresnel inferior.
Radio_sup = Fresnel_Y + Fresnel;            % Radio de fresnel superior.

% Nuevas alturas calculadas para las antenas.
nueva_altura_antena1 = hreal(1)-h(1) + antena1;     %
nueva_altura_antena2 = hreal(end)-h(end) + antena2;

figure(3)
plot(distance,h,'blue')
hold on
plot(distance,hcalculado,'g') 
plot(distance,Fresnel_Y,'b','LineWidth',2)
plot(distance,Radio_inf,'-*r')
plot(distance,Radio_sup,'-*r')
hold off
title('Enlace de Radio'); 
xlabel('Distancia (Km)');
ylabel('Altura (m)');
legend('Altura','Altura + Vegetacion + fresnel (10m)','Linea de Vista','Zona de Fresnel','location','best');


