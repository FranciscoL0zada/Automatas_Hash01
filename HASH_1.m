%% Crear un algorimo de Automata celular por medio de una llave de HASH1
clc; clear; close all;
[X,Map]=imread("LENA1.BMP");
figure(1),subplot(2,3,1),imshow(X),title("IMAGEN ORIGINAL");


%%%SE REALIZA LA BINARIZACION DE LA IMAGEN 
X_Bin=imbinarize(X);
figure(1),subplot(2,3,2),imshow(X_Bin),title("IMAGEN BINARIZADA");
t=size(X_Bin);
%Se obtiene la llave hash1 de la imagen original

llave =llave_HASH_1(X);

t_llave=size(llave);
%% una llave has esta compuesta por 160 bits los cuales se reparten en dos
%%vectores 

V1=zeros(1,80);
V2=zeros(1,80);
j=1;
h=1;
for i=1:t_llave(1,1)
    llave(i,:);
    hexToBinaryVector(llave(i,1),4);
    hexToBinaryVector(llave(i,2),4);
    if (i<=(t_llave(1,1)/2))
        V1(j:j+3)=hexToBinaryVector(llave(i,1),4);
        V1(j+4:j+7)=hexToBinaryVector(llave(i,2),4);
        j=j+8;
    else 
        V2(h:h+3)=hexToBinaryVector(llave(i,1),4);
        V2(h+4:h+7)=hexToBinaryVector(llave(i,2),4);
        h=h+8;
    end 
    
end 


%% dentro de los dos arreglos se realiza un XOR exclusiva para obtener una resultante 
V_X=xor(V1,V2);
semilla=0;
for i=1:4:77
    semilla=semilla+bin2dec(num2str(V_X(i:i+3)));
end


%% se realiza un arreglo de numeros aleatorios  tomando como semilla 
%el valor resultante de SHA-1

rng(semilla);
A=rand(t)>0.65;

figure(1),subplot(2,3,3),imshow(A),title("LLAVE K-HASH1");


%%se realiza el recorrido del automata celular dentro de la imagen
%%binarizada
K=11;
%a=512;
aux1=zeros(1,512*512);
aux1(:)=X_Bin(:);
% for j=2:a
 we=aux1(:);
    for i=1:K
        we = encoder_R15_Circular_list(we);
    end
% aux1(j,:)=we;
% end

aux= reshape(we(1,:),[t(1),t(2)]);
figure(1),subplot(2,3,4),imshow(aux),title('IMAGEN AUTOMATAS');

b=psnr(uint8(X_Bin),uint8(aux));


%% Creamos Master SHARE
%Se realiza una xor entre las dos imagenes resultantes

M_S=xor(A,aux);
figure(1),subplot(2,3,5),imshow(M_S),title('IMAGEN MASTER SHARE');

%%SE GUARDA MSI

imwrite(M_S,'MSI.bmp');



