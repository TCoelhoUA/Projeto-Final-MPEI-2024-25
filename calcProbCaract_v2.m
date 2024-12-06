function [classes_produtos, probsSEM, probsFIMSEM] = calcProbCaract(produtos, classes, caracteristicas,h)
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

    for car=1:length(caracteristicas)
        freq = 0; % frequencia do produto

        for produto=1:length(produtos)
            if strcmp(produtos{produto}, caracteristicas{car})
                if classes(produto) == "SEMANA"
                    probsSEM(car) = probsSEM(car) +1/5;
                    freq = freq + 1/5;
                else
                    probsFIMSEM(car) = probsFIMSEM(car) +1/2;
                    freq = freq + 1/2;
                end
            end
        end
        if (freq == 0)
            classes_produtos(car) = 'N/A';
            break;
        end
        probsSEM(car) = probsSEM(car)/freq;
        probsFIMSEM(car) = probsFIMSEM(car)/freq;
        if (probsSEM(car) > probsFIMSEM(car))
            classes_produtos(car) = 'SEMANA';
        else
            classes_produtos(car) = 'FIM DE SEMANA';
        end
        waitbar(2/6+1/6*car/length(caracteristicas), h, 'A atribuir classes aos produtos...');
    end
end