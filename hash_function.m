function hc = hash_function(elemento, k, R, p)
    % USAGE:
    % hc = hash_function("Toy", 3, randi(127, 100, 3), 127);
    
    codigos_ASCII = double(elemento);   % vetor com código ASCII
    r = R(k,:);

    hc = mod(codigos_ASCII * r', p);
end