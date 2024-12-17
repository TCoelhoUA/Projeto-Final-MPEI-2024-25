function hc = hash_function(elemento, k, R, p)
    % <strong>USAGE: hash_function(elemento, k, R, p)</strong>
    % Devolve um hashcode de um elemento
    %
    % <strong>Input:</strong>
    % <strong>elemento</strong> - elemento atual
    % <strong>k</strong> - Hash Funtion atual
    % <strong>R</strong> - Matriz aleatória 
    % <strong>p</strong> - Número primo
    %
    % <strong>Output:</strong>
    % <strong>hc</strong> - Hashcode
    
    codigos_ASCII = double(elemento);   % vetor com código ASCII
    r = R(k,:);
    hc = mod(codigos_ASCII * r', p);
end