function distancias = distJ(carrinho, carrinhos)
    %distancias = zeros(length(carrinhos)-1, 1);   % vetor com distâncias de jaccard
    distancias = [];
    
    carrinho_mat = {};
    for item = 1:50
        if ismissing(carrinho{item})
            break
        end
        carrinho_mat{end+1} = carrinho{item};
    end

    for c = 2:length(carrinhos)
        car = {};
        for i = 1:11
            if ismissing(carrinhos{c,i})
                break
            end
            car{end+1} = carrinhos{c,i};
        end
        distJ = numel(intersect(car, carrinho_mat))/numel(union(car, carrinho_mat));
        distancias(end+1, 1) = distJ;
    end
end

