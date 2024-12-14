function [classes_produtos, product_prob, freq] = calculo_prob_caract(produtos, classes, caracteristicas,h)
    % <strong>USAGE: calculo_prob_caract</strong>
    % Associa uma classe a cada produto com base em compras individuais de cada produto no passado
    %
    % <strong>Input:</strong>
    % <strong>produtos</strong> - Registos de venda dos produtos (incluindo repetidos)
    % <strong>classes</strong> - Classes associadas a cada compra
    % <strong>caracteristicas</strong> - Todos os tipos únicos de produtos do dataset
    % <strong>h</strong> - Waitbar associada
    %
    % <strong>Output:</strong>
    % <strong>classes_produtos</strong> - Classes principais associadas a cada produto, com base na probabilidade de ser vendido durante a semana ou fim de semana (o produto é classificado com base na probabilidade dominante)
    % <strong>product_prob</strong> - Matriz com 2 colunas: P(Característica|"SEMANA") e P(Característica|"FIM DE SEMANA")
    % <strong>freq</strong> - Número de vezes que cada produto foi vendido

    classes_produtos = categorical(zeros(size(caracteristicas, 1),1));
    probsSEM = zeros(length(caracteristicas), 1);
    probsFIMSEM = zeros(length(caracteristicas), 1);
    freq = zeros(length(caracteristicas), 1);

    for car=1:length(caracteristicas)
        frequencia = 0; % frequenciauencia do produto

        for produto=1:length(produtos)
            if strcmp(produtos{produto}, caracteristicas{car})
                frequencia = frequencia + 1;
                if classes(produto) == "SEMANA"
                    probsSEM(car) = probsSEM(car) +1;
                else
                    probsFIMSEM(car) = probsFIMSEM(car) +1;
                end
            end
        end
        freq(car) = frequencia;
        if (frequencia == 0)
            classes_produtos(car) = 'N/A';
            break;
        end
        probsSEM(car) = probsSEM(car)/frequencia;
        probsFIMSEM(car) = probsFIMSEM(car)/frequencia;
        if (probsSEM(car) > probsFIMSEM(car))
            classes_produtos(car) = 'SEMANA';
        else
            classes_produtos(car) = 'FIM DE SEMANA';
        end
        waitbar(2/6+1/6*car/length(caracteristicas), h, 'A atribuir classes aos produtos...');
    end
    product_prob(:, 1) = probsSEM;
    product_prob(:, 2) = probsFIMSEM;
end