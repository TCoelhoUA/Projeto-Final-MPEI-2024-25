function BF = BF_inicializar(n)
    % <strong>USAGE: BF_inicializar(n)</strong>
    % Inicializa o bit-array do Bloom Filter com zeros.
    %
    % <strong>Input</strong>:
    % <strong>n</strong> - tamanho do BF
    %
    % <strong>Output:</strong>
    % <strong>BF</strong> - bit array

    BF = zeros(1, n, 'uint8');      % uint8 - Se omitissemos, seria um array de 'doubles' e não de 'bits'
end

