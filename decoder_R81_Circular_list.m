% Cellular Automata (CA) Rule-85 for decode 1-D watermarks
% Author: Ph.D Manuel Cedillo Hernandez, 2022 (c)
% Inputs:
% we: The binary 1-D encoded watermark [1,0]
% Outputs:
% wd : The decoded watermark
% Modified by: Francisco Lozada
% Add logic for circular list



function wd = decoder_R81_Circular_list(we)

Wtemp = we;

% Rellenar la señal we con 2 bits adicionales con valor "0"
% Wtemp(length(we)+1) = 0; Wtemp(length(Wtemp)+1) = 0;

% Aumentar un "0" en cada extremo de la señal we
Wtemp_ = zeros(1,length(Wtemp)+2);
Wtemp_(2:length(Wtemp_)-1) = Wtemp(:);


% crear una lista circular dentro del vector
Wtemp_(length(Wtemp_)) = we(1); 
Wtemp_(1) = we(length(we));

% Se definen los prefijos de la ventana de la Rule-85
a = [1 1 1]; b = [1 1 0]; c = [1 0 1]; d = [1 0 0]; e = [0 1 1]; f = [0 1 0]; g = [0 0 1]; h = [0 0 0];

% Arreglo donde se almacena la marca de agua codificada 
wd = ones(1,length(we));

% Indices para caminar la ventana del CA 
i1 = 1; i2 = 3;

for l = 1 : length(we)
    
    if (Wtemp_(i1:i2)==a(1,:)) wd(l) = 0; end
    if (Wtemp_(i1:i2)==b(1,:)) wd(l) = 1; end
    if (Wtemp_(i1:i2)==c(1,:)) wd(l) = 0; end
    if (Wtemp_(i1:i2)==d(1,:)) wd(l) = 1; end
    if (Wtemp_(i1:i2)==e(1,:)) wd(l) = 0; end
    if (Wtemp_(i1:i2)==f(1,:)) wd(l) = 0; end
    if (Wtemp_(i1:i2)==g(1,:)) wd(l) = 0; end
    if (Wtemp_(i1:i2)==h(1,:)) wd(l) = 1; end

    i1 = i1 + 1; i2 = i2 + 1;

end
