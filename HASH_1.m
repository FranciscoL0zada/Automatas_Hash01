%% Crear un algorimo de Automata celular por medio de una llave de HASH1

clc; clear; close all;
[X,Map]=imread("LENA1.BMP");
%%[X,Map,n]=imread("1 (500).jpg");
ps=1;
figure(1),subplot(3,3,ps),imshow(X),title("IMAGEN ORIGINAL");
ps=ps+1;
%%Determina el numero de planos que contiene la imagen
s=size(X);
np=numel(s);

if np==2 
    disp('Imagen de 2 planos');
else
    disp('Imagen de 3 planos');
end 


%%SE REALIZA LA BINARIZACION DE LA IMAGEN 
%%si la imagen es en dos planos 
if np>2
    X=rgb2gray(X);
    figure(1),subplot(3,3,ps),imshow(X),title("IMAGEN Blanco y Negro");
    ps=ps+1;
end
%%Se binariza la imagen en blanco y negro
X_Bin=imbinarize(X);

figure(1),subplot(3,3,ps),imshow(X_Bin),title("IMAGEN BINARIZADA");
ps=ps+1;
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

%crea la semilla apartir de 4 bits de izquierda a derecha, creando una
%
semilla=0;
for i=1:4:77
    semilla=semilla+bin2dec(num2str(V_X(i:i+3)));
end


%% se realiza un arreglo de numeros aleatorios  tomando como semilla 
%el valor resultante de SHA-1

rng(semilla);
A=rand(t)>0.65;

figure(1),subplot(3,3,ps),imshow(A),title("LLAVE K-HASH1");
ps=ps+1;

%%se realiza el recorrido del automata celular dentro de la imagen
%%binarizada
K=11;
%a=512;
aux1=ones(1,t(1)*t(2));
aux1(:)=X_Bin(:);
% for j=2:a
 we=aux1(:);
    for i=1:K
        we = encoder_R15_Circular_list(we);
    end
% aux1(j,:)=we;
% end

aux= reshape(we(1,:),[t(1),t(2)]);
figure(1),subplot(3,3,ps),imshow(aux),title('IMAGEN AUTOMATAS');
ps=ps+1;
b=psnr(uint8(X_Bin),uint8(aux));


%% Creamos Master SHARE
%Se realiza una xor entre las dos imagenes resultantes
A_(1,:)=A(:);
we_=we(1,:);
M_S=xor(A_,we_);

MS1=reshape(M_S,[t(1),t(2)]);
MS1=uint8(MS1*255);
%%M_S=uint8(M_S);
figure(1),subplot(3,3,ps),imshow(MS1),title('IMAGEN MASTER SHARE');
%%SE GUARDA MSI
imwrite(M_S,'MSI.BMP');