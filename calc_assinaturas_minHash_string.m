function assinaturas = calc_assinaturas_minHash_string(shingles,nhf, R, p)
    % <strong>USAGE: calc_assinaturas_minHash_string</strong>
    % EXPLICAÇÃO AQUI
    %
    % <strong>Input:</strong>
    % <strong>shingles</strong> - EXPLICAÇÃO AQUI
    % <strong>nhf</strong> - Número de funções de hash
    % <strong>R</strong> - EXPLICAÇÃO AQUI
    % <strong>p</strong> - Número primo
    %
    % <strong>Output:</strong>
    % <strong>assinaturas</strong> - Assinaturas de cada produto
    
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