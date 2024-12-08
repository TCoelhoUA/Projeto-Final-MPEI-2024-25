function BF = inicializarBF(n)
    % Inicializa o bit-array do Bloom Filter com zeros.
    %
    % Parâmetros:
    % n - tamanho do BF
    %
    % Output:
    % BF - bit array

    BF = zeros(1, n, 'uint8');      % uint8 - Se omitissemos, seria um array de 'doubles' e não de 'bits'
end

