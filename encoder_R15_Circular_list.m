% Cellular Automata (CA) Rule-15 for encode 1-D watermarks
% Author: Ph.D Manuel Cedillo Hernandez, 2022 (c)
% Inputs:
% W: The binary 1-D watermark [1,0]
% Outputs:
% we : The encoded watermark
% Modified by: Francisco Lozada
% Add logic for circular list

function we = encoder_R15_Circular_list(W)

Wtemp = W;

% Rellenar la señal W con 2 bits adicionales con valor "1"
% Wtemp(length(W)+1) = 1; Wtemp(length(Wtemp)+1) = 1;


% Aumentar un "0" en cada extremo de la señal W
 Wtemp_ = zeros(1,length(Wtemp)+2);
 Wtemp_(2:length(Wtemp_)-1) = Wtemp(:);


% crear una lista circular dentro del vector
Wtemp_(length(Wtemp_)) = W(1); 
Wtemp_(1) = W(length(W));


% Aumentar un "0" en cada extremo de la señal W
% Wtemp_ = zeros(1,length(Wtemp)+2);
% Wtemp_(2:length(Wtemp_)-1) = Wtemp(:);



% Se definen los prefijos de la ventana de la Rule-15
a = [1 1 1]; b = [1 1 0]; c = [1 0 1]; d = [1 0 0]; e = [0 1 1]; f = [0 1 0]; g = [0 0 1]; h = [0 0 0];

% Arreglo donde se almacena la marca de agua codificada 
we = ones(1,length(W));

% Indices para caminar la ventana del CA 
i1 = 1; i2 = 3;

for l = 1 : length(W)
    
    if (Wtemp_(i1:i2)==a(1,:)) we(l) = 0; end
    if (Wtemp_(i1:i2)==b(1,:)) we(l) = 0; end
    if (Wtemp_(i1:i2)==c(1,:)) we(l) = 0; end
    if (Wtemp_(i1:i2)==d(1,:)) we(l) = 0; end
    if (Wtemp_(i1:i2)==e(1,:)) we(l) = 1; end
    if (Wtemp_(i1:i2)==f(1,:)) we(l) = 1; end
    if (Wtemp_(i1:i2)==g(1,:)) we(l) = 1; end
    if (Wtemp_(i1:i2)==h(1,:)) we(l) = 1; end

    i1 = i1 + 1; i2 = i2 + 1;

end

