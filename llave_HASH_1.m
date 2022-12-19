function llave=llave_HASH_1(image)
    %image = imread('lena.jpg'); % Read in the im|age 
    [m, n, ~] = size(image);       % Gives rows, columns, ignores number of channels
    % Starts by separating the image into RGB channels
%     message_R = image(:,:,1);      % Red channel
%     message_G = image(:,:,2);      % Green channel
%     message_B = image(:,:,3);      % Blue channel
%     flat_R = reshape(image(:,:,1)',[1 m*n]); % Reshapes Red channel matrix into a 1 by m*n uint8 array
%     flat_G = reshape(image(:,:,2)',[1 m*n]); % 
%     flat_B = reshape(image(:,:,3)',[1 m*n]); % 
    
    flat = reshape(image,[1 m*n]);

%     flat_RGB = [flat_R, flat_G, flat_B];     % Concatenates all RGB vals, into one long 1 by 3*m*n array
    string = num2str(flat);                         % Converts numeric matrices to a string
    string = string(~isspace(num2str(string))); % Removes spaces - though this is not strictly necessary I think
    % Perform hashing
    sha1hasher = System.Security.Cryptography.SHA1Managed;           % Create hash object (?) - this part was copied from the forum post mentioned above, so no idea what it actually does
    imageHash_uint8 = uint8(sha1hasher.ComputeHash(uint8(string))); % Find uint8 of hash, outputs as a 1x32 uint8 array
    llave = dec2hex(imageHash_uint8); % Convert uint8 to hex, if necessary. This step is optional depending on your application.


end 
