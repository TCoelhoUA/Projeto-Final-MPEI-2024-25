function assinaturas = calc_assinaturas_minHash_string(shingles,nhf, R, p)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
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