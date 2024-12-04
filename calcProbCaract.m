function classes_produtos = calcProbCaract(produtos, classes, caracteristicas)
    % Associa uma classe a cada produto com base em compras individuais de
    % cada produto no passado
    %
    % Input:
    % produtos - cell array com os registos de venda dos produtos (incluindo repetidos)
    % classes - cell array com as classes associadas a cada compra
    % registada em 'produtos'
    % caracteristicas - cell array com os produtos não repetidos
    %
    % Ouput:
    % classes_produtos - cell array com classes associadas a cada produto,
    % com base na probabilidade de ser vendido durante a semana ou fim de
    % semana (o produto é classificada com base na probabilidade dominante)

    classes_produtos = categorical(zeros(size(caracteristicas, 1),1));
    
    for car=1:length(caracteristicas)
        s = 0;
        fs = 0;
        freq = 0; % frequencia do produto

        for produto=1:length(produtos)
            if strcmp(produtos{produto}, caracteristicas{car})
                freq = freq + 1;
                if classes(produto) == "SEMANA"
                    s = s+1;
                else
                    fs = fs;
                end
            end
        end
        if (freq == 0)
            classes_produtos(car) = 'N/A';
            break;
        end
        if (s/freq > fs/freq)
            classes_produtos(car) = 'SEMANA';
        else
            classes_produtos(car) = 'FIM DE SEMANA';
        end
    end
end