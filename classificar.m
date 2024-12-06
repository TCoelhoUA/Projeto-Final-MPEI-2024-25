function classes_carrinhos = classificar(carrinhos, caracteristicas, product_prob, h)
    % Esta função classifica os carrinhos como 'SEMANA' ou 'FIM DE SEMANA'
    % com base nos produtos que contém e as suas respetivas probabilidades

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
            %fprintf("PRODUTO: %s\nSEMANA: %f\nFIM DE SEMANA: %f\n\n\n", caracteristicas{car}, probSEM, probFIMSEM); for debuging
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

