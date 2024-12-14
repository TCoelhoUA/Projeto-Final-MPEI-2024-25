function assinaturas = minHash_calcular_assinaturas_string(shingles,nhf, R, p)
    % <strong>USAGE: minHash_calcular_assinaturas_string(shingles,nhf, R, p)</strong>
    % Calcula as assinaturas de uma dada string por nhf hash functions
    %
    % <strong>Input:</strong>
    % <strong>shingles</strong> - array com os shingles da string
    % <strong>nhf</strong> - Número de funções de hash
    % <strong>R</strong> - Matriz aleatória
    % <strong>p</strong> - Número primo
    %
    % <strong>Output:</strong>
    % <strong>assinaturas</strong> - Assinaturas do produto para cada hash funtion
    
    assinaturas = zeros(nhf, 1); % linha = hash function
    
    % para cada funcao de hash
    for hf = 1:nhf
        hc = zeros(1, length(shingles));
        for nelem = 1:length(shingles)
            elemento = shingles{nelem};
            hc(nelem) = hash_function(elemento, hf, R, p);
        end
        minHash = min(hc);

        assinaturas(hf) = minHash;
    end
end