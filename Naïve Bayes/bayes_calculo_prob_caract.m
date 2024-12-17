function [product_prob, freq] = bayes_calculo_prob_caract(carrinhos, caracteristicas)
    % <strong>USAGE: bayes_calculo_prob_caract</strong>
    % Associa uma classe a cada produto com base em compras individuais de cada produto no passado
    %
    % <strong>Input:</strong>
    % <strong>produtos</strong>         - Registos de venda dos produtos (incluindo repetidos)
    % <strong>classes</strong>          - Classes associadas a cada compra
    % <strong>caracteristicas</strong>  - Todos os tipos únicos de produtos do dataset
    % <strong>h</strong>                - Waitbar associada
    %
    % <strong>Output:</strong>
    % <strong>classes_produtos</strong> - Classes principais associadas a cada produto, com base na probabilidade de ser vendido durante a semana ou fim de semana (o produto é classificado com base na probabilidade dominante)
    % <strong>product_prob</strong>     - Matriz com 2 colunas: P(Característica|"SEMANA") e P(Característica|"FIM DE SEMANA")
    % <strong>freq</strong>             - Número de vezes que cada produto foi vendido

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