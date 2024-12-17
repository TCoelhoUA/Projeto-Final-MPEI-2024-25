function [MA, h] = minHash_calcular_assinaturas(shingles, nhf, R, p, h)
    % <strong>USAGE: minHash_calcular_assinaturas(shingles, nhf, R, p)</strong>
    % Calcula a matriz assinatura
    %
    % <strong>Input:</strong>
    % <strong>shingles</strong> -  Shingles dos produtos
    % <strong>nhf</strong> - Número de funções de hash
    % <strong>R</strong> - Matriz aleatória
    % <strong>p</strong> - Número de primo
    % <strong>h</strong> - waitbar atual
    %
    % <strong>Output:</strong>
    % <strong>MA</strong> - Matriz assinatura
    % <strong>h</strong> - waitbar atualizada
    
    Np = length(shingles);
    MA = zeros(nhf, Np);
    
    % para cada funcao de hash
    for hf = 1:nhf
    % para cada use (mais propriamente conjunto desse user)
        for conjunto_i= 1:Np
            conjunto = shingles{conjunto_i};
            hc = zeros(1, length(conjunto));
            for nelem = 1:length(conjunto)
                elemento = conjunto{nelem};
                hc(nelem) = hash_function(elemento, hf, R, p);
            end
            minHash = min(hc);

            MA(hf, conjunto_i) = minHash;
        end
        waitbar(5/6 + 1/6*hf/nhf, h, 'A calcular a matriz assinatura...');
    end
end