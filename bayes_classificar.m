function classes_carrinhos = bayes_classificar(carrinhos, caracteristicas, product_prob, h)
    % <strong>USAGE: bayes_classificar</strong>
    % Classifica os carrinhos como "SEMANA" ou "FIM DE SEMANA" com base nos produtos que contêm e as suas respetivas probabilidades
    %
    % <strong>Input:</strong>
    % <strong>carrinhos</strong> - Todos os carrinhos do dataset
    % <strong>caracteristicas</strong> - Todos os tipos únicos de produtos do dataset
    % <strong>product_prob</strong> - Matriz com 2 colunas: P(Característica|"SEMANA") e P(Característica|"FIM DE SEMANA")
    % <strong>h</strong> - Waitbar associada
    %
    % <strong>Output:</strong>
    % <strong>classes_carrinhos</strong> - Classes dos carrinhos

    classes_carrinhos = categorical();
    for carrinho=2:length(carrinhos)
        probSEM = 1;
        probFIMSEM = 1;
        for col=1:11
            if ismissing(carrinhos{carrinho, col}) 
                break;
            end
            for car=1:length(caracteristicas)
                if strcmp(carrinhos{carrinho, col}, caracteristicas(car))
                    probSEM = probSEM*product_prob(car, 1);
                    probFIMSEM = probFIMSEM*product_prob(car, 2);
                end
            end
        end
        if probSEM > probFIMSEM
            classes_carrinhos(carrinho-1, 1) = "SEMANA";
        elseif probSEM < probFIMSEM
            classes_carrinhos(carrinho-1, 1) = "FIM DE SEMANA";
        else
            classes_carrinhos(carrinho-1, 1) = "N/A";
        end
        waitbar(4/6+1/3*(carrinho-1)/(length(carrinhos)-1), h, 'A classificar os carrinhos...');
    end
end

