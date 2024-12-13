function MA = calcular_assinaturas(Set, nhf, R, p)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
    Np = length(Set);
    MA = zeros(nhf, Np);
    
    % para cada funcao de hash
    for hf = 1:nhf
    % para cada use (mais propriamente conjunto desse user)
        for conjunto_i= 1:Np
            conjunto = Set{conjunto_i};
            hc = zeros(1, length(conjunto));
            for nelem = 1:length(conjunto)
                elemento = conjunto{nelem};
                hc(nelem) = hash_function(elemento, hf, R, p);
            end
            minHash = min(hc);

            MA(hf, conjunto_i) = minHash;
        end
    end
end