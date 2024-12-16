function MA = minHash_calcular_assinaturas(shingles, nhf, R, p)
    % <strong>USAGE: minHash_calcular_assinaturas(shingles, nhf, R, p)</strong>
    % Calcula a matriz assinatura
    %
    % <strong>Input:</strong>
    % <strong>shingles</strong> -  Shingles dos produtos
    % <strong>nhf</strong>      -  Número de funções de hash
    % <strong>R</strong>        -  Matriz aleatória
    % <strong>p</strong>        -  Número de primo
    %
    % <strong>Output:</strong>
    % <strong>MA</strong>       - Matriz assinatura
    
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
                %waitbar(4/6+2/6*hf/nhf*nelem/length(conjunto), h, 'A calcular a matriz assinatura...');
            end
            minHash = min(hc);

            MA(hf, conjunto_i) = minHash;
        end
    end
end