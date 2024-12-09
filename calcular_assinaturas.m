function assinaturas = calcular_assinaturas(Set, k, R, p)
    %% Calcular matriz MinHash (MH)
    MH = zeros(k, length(Set));
    Set = Set';
    % para cada hash functions
    for hf=1:k
        % para cada user (mais propriamente conjunto desse user)
        for filme = 1:length(Set)
            conjunto = Set{filme};
            hash_codes = zeros(1, length(conjunto));
            % para cada elemento desse conjuntos
            for el=1:length(conjunto)
                % aplicar hash function (k)
                elemento = conjunto{el};
                hash_codes(el) = hash_function(elemento, hf, R, p);
            end
            % obter hash code minimo (mais baixo)
            minhash = min(conjunto{el});

            % guardar em MH
            MH(hf, filme) = minhash;
        end
    end
    delete(h);

    %{
    %% Calcular distância de Jaccard (distJ)
    % para cada user
    for n1=1:Nu
        % para todos os outros
        for n2=n1:Nu
            % obter as 2 assinaturas (que são colunas)
            assinatura1 = MH(:,n1);
            assinatura2 = MH(:,n2);

            % calcular numero de valores iguais na mesma posição
            assinaturas_iguais = sum(assinatura1 == assinatura2);

            % distância = número de valores iguais/k
            distJ = 1 - assinaturas_iguais/k;
        end
    end
    %}
end