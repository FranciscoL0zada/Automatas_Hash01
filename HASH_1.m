%% Crear un algorimo de Automata celular por medio de una llane de HASH1

clc; clear; close all;

[X,Map]=imread("lena.jpg");
figure(1),subplot(1,3,1),imshow(X),title("IMAGEN ORIGINAL");
%%%SE REALIZA LA BINARIZACION DE LA IMAGEN 
X_Bin=imbinarize(X);
figure(1),subplot(1,3,2),imshow(X_Bin),title("IMAGEN BINARIZADA");


