function classe_carrinho = bayes_classificar_carrinho(carrinho, caracteristicas, product_prob)
    % <strong>USAGE: bayes_classificar_carrinho</strong>
    % Classifica o carrinho como "SEMANA" ou "FIM DE SEMANA" com base nos produtos que contém e as suas respetivas probabilidades
    %
    % <strong>Input:</strong>
    % <strong>carrinho</strong> - Carrinho atual do utilizador
    % <strong>caracteristicas</strong> - Todos os tipos únicos de produtos do dataset
    % <strong>product_prob</strong> - Matriz com 2 colunas: P(Característica|"SEMANA") e P(Característica|"FIM DE SEMANA")
    %
    % <strong>Output:</strong>
    % <strong>classe_carrinho</strong> - Classe do carrinho

    probSEM = 1;
    probFIMSEM = 1;
    classe_carrinho = "N/A";
    for p = 1:length(carrinho)
        if ismissing(carrinho{p}) 
            return
        end
        for car=1:length(caracteristicas)
            if strcmp(carrinho{p}, caracteristicas(car))
                % itens cuja probabilidade seja 0 em SEM ou FIMSEM serão
                % ignorados de forma a não anularem a totalidade da
                % probabilidade
                if product_prob(car, 1) ~= 0 && product_prob(car, 2) ~= 0
                    probSEM = probSEM*product_prob(car, 1);
                    probFIMSEM = probFIMSEM*product_prob(car, 2);
                end
            end
        end

        if probSEM > probFIMSEM
            classe_carrinho = "SEMANA";
        elseif probSEM < probFIMSEM
            classe_carrinho = "FIM DE SEMANA";
        else
            classe_carrinho = "N/A";
        end
    end
end