function [product_prob, freq] = bayes_calculo_prob_caract(carrinhos, caracteristicas)
    % <strong>USAGE: bayes_calculo_prob_caract</strong>
    % Associa uma classe a cada produto com base em compras individuais de cada produto no passado
    %
    % <strong>Input:</strong>
    % <strong>carrinhos</strong> - Cell array de carrinhos
    % <strong>caracteristicas</strong> - Todos os tipos únicos de produtos do dataset
    %
    % <strong>Output:</strong>
    % <strong>product_prob</strong> - Matriz com 2 colunas: P(Característica|"SEMANA") e P(Característica|"FIM DE SEMANA")
    % <strong>freq</strong> - Número de vezes que cada produto foi vendido

    probsSEM = zeros(numel(caracteristicas), 1);
    probsFIMSEM = zeros(numel(caracteristicas), 1);
    freq = zeros(numel(caracteristicas), 1);
    
    for produto = 1:numel(caracteristicas)
        for car = 1:numel(carrinhos)
            classe = carrinhos{car}{1};
            if any(ismember(carrinhos{car}, caracteristicas(produto)))
                freq(produto) = freq(produto) + 1;
                if strcmp(classe, "SEMANA")
                    probsSEM(produto) = probsSEM(produto) + 1;
                else
                    probsFIMSEM(produto) = probsFIMSEM(produto) + 1;
                end
            end
        end
    end
    
    probsSEM = probsSEM./freq;
    probsFIMSEM = probsFIMSEM./freq;
    product_prob = [probsSEM probsFIMSEM];
end