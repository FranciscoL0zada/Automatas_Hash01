%%ALGOTIRMO DE RECUPERACION DE IMAGEN
%%ENTRADA DE MSI
clc; clear; close all;
[X,Map]=imread("MSI.bmp");
figure(1),subplot(3,3,1),imshow(X),title("IMAGEN MSI");

%%%%IMAGEN DE ENTRADA
[I,Map]=imread("LENA1.BMP");
figure(1),subplot(3,3,4),imshow(I),title("IMAGEN ENTRADA");


s=size(I);
np=numel(s);

if np==2 
    disp('Imagen de 2 planos');
else
    disp('Imagen de 3 planos');
end 


%%SE REALIZA LA BINARIZACION DE LA IMAGEN 
%%si la imagen es en dos planos 
if np>2
    I=rgb2gray(I);
    %%figure(1),subplot(3,3,ps),imshow(I),title("IMAGEN Blanco y Negro");

end
I_Bin=imbinarize(I);
figure(1),subplot(3,3,5),imshow(I_Bin),title("IMAGEN BINARIZADA");

t=size(I_Bin);

%%%SE REALIZA LA BINARIZACION DE LA IMAGEN 
[W,Map]=imread("LENA1.BMP");
figure(1),subplot(3,3,2),imshow(W),title("IMAGEN ORIGINAL");
t=size(I_Bin);

W_Bin=imbinarize(W);
figure(1),subplot(3,3,3),imshow(W_Bin),title("IMAGEN ORIGINAL BINARIZADA");


%Se obtiene la llave hash1 de la imagen original

llave =llave_HASH_1(I);

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

figure(1),subplot(3,3,6),imshow(A),title("LLAVE K-HASH1");


%%PROCESO DE XOR CON MSI Y MATRIZ HASH-1
A_(1,:)=A(:);
I_AUTOMATA=xor(A_,X);

figure(1),subplot(3,3,7),imshow(I_AUTOMATA),title('IMAGEN HASH-1 XOR MSI');

K=11;
%a=512;
aux1=zeros(1,512*512);
aux1(:)=I_AUTOMATA(:);
% for j=2:a
 we=aux1(:);
    for i=1:K
        we = decoder_R85_Circular_list(we);
    end
aux= reshape(we(1,:),[t(1),t(2)]);
figure(1),subplot(3,3,8),imshow(aux),title('IMAGEN RECUPERADA DESPUES DE AUTOMATA');


b=psnr(uint8(I_Bin),uint8(aux))

if b==inf
    disp('Imagen sin alteraciones');
else
    disp('Imagen con alteraciones');

end 

  


