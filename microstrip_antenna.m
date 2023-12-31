%Andy Paulo Ramírez 1087586
% Create a patchMicrostrip antenna
% Generated by MATLAB(R) 9.8 and Antenna Toolbox 4.2.
% Generated on: 09-Apr-2021 16:24:25

%% Antenna Properties 
% Design antenna at frequency 500000000Hz
antennaObject = design(patchMicrostrip,500000000);
% Properties changed 
antennaObject.Length = 0.2056;
antennaObject.Width = 0.2405;
% Update substrate properties 
antennaObject.Substrate.Name = 'Teflon';
antennaObject.Substrate.EpsilonR = 2.1;
antennaObject.Substrate.LossTangent = 0.0002;
antennaObject.Substrate.Thickness = 0.00599584916;

%% Antenna Analysis 
% Define plot frequency 
plotFrequency = 500000000;
% Define frequency range 
freqRange = (450:5:550) * 1e6;
% show for patchMicrostrip
figure;
show(antennaObject) 
% pattern for patchMicrostrip
figure;
pattern(antennaObject, plotFrequency) 
% current for patchMicrostrip
figure;
current(antennaObject, plotFrequency) 
% azimuth for patchMicrostrip
figure;
patternAzimuth(antennaObject, plotFrequency) 
% elevation for patchMicrostrip
figure;
patternElevation(antennaObject, plotFrequency) 
% s11 for patchMicrostrip
%figure;
%s = sparameters(antennaObject, freqRange); 
%rfplot(s) 
% impedance for patchMicrostrip
%figure;
%impedance(antennaObject, freqRange) 

