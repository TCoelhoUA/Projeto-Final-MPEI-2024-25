function [classes_produtos, product_prob, freq] = calcProbCaract(produtos, classes, caracteristicas,h)
    % Associa uma classe a cada produto com base em compras individuais de
    % cada produto no passado
    %
    % Input:
    % produtos - cell array com os registos de venda dos produtos (incluindo repetidos)
    % classes - cell array com as classes associadas a cada compra
    % registada em 'produtos'
    % caracteristicas - cell array com os produtos não repetidos
    % h - waitbar associada
    %
    % Ouput:
    % classes_produtos - cell array com classes associadas a cada produto,
    % com base na probabilidade de ser vendido durante a semana ou fim de
    % semana (o produto é classificada com base na probabilidade dominante)
    % probsSEM - probabilidade do produto ser comprado num dia de semana
    % probsFIMSEM - probabilidade do produto ser comprado num fim de semana
    
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