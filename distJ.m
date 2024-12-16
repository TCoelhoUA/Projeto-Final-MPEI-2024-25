function distancias = distJ(carrinho, carrinhos)
    %distancias = zeros(length(carrinhos)-1, 1);   % vetor com distâncias de jaccard
    distancias = [];
    
    %carrinho_mat = {};
    carrinho_mat = [];
    for item = 1:numel(carrinhos)
        if ismissing(carrinho{item})
            break
        end
        %carrinho_mat{end+1} = carrinho{item};
        carrinho_mat = [carrinho_mat , carrinho{item}];
    end
    %disp(carrinho_mat)

    for c = 1:numel(carrinhos)
        %car = {};
        car = [];
        for i = 3:numel(carrinhos{c})
            %car{end+1} = carrinhos{c}(i);
            car = [car carrinhos{c}(i)];
        end
        %disp(car)
        %disp(carrinho_mat)
        distJ = numel(intersect(car, carrinho_mat))/numel(union(car, carrinho_mat));
        distancias(end+1, 1) = distJ;
    end
end

