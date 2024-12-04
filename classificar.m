function [classes_carrinhos, probsSEM, probsFIMSEM] = classificar(carrinhos, produtos, classes, caracteristicas)
    % Esta função classifica os carrinhos como 'SEMANA' ou 'FIM DE SEMANA'
    % com base nos produtos que contém e as suas respetivas probabilidades

    probsSEM = zeros(1, length(caracteristicas));
    probsFIMSEM = zeros(1, length(caracteristicas));

    for car=1:length(caracteristicas)
        freq = 0; % frequencia do produto

        for produto=1:length(produtos)
            if strcmp(produtos{produto}, caracteristicas{car})
                freq = freq + 1;
                if classes(produto) == "SEMANA"
                    probsSEM(car) = probsSEM(car) +1;
                else
                    probsFIMSEM(car) = probsFIMSEM(car) +1;
                end
            end
        end
        probsSEM(car) = probsSEM(car)/freq;
        probsFIMSEM(car) = probsFIMSEM(car)/freq;
    end

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
                    probSEM = probSEM*probsSEM(car);
                    probFIMSEM = probFIMSEM*probsFIMSEM(car);
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
        fprintf("PRODUTO: %s\nSEMANA: %f\nFIM DE SEMANA: %f\n\n\n", caracteristicas{car}, probSEM, probFIMSEM);
    end
end
