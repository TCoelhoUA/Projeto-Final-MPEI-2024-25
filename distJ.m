function distancias = distJ(carrinho, carrinhos)
    %{

    FAZER MATRIZ MH PARA APENAS COMPARAR COM OS HASH CODES QUANDO O
    CARRRINHO ATUALIZA

    disp(carrinhos)
    distancias = zeros(length(carrinhos), 1);   % vetor com distâncias de jaccard

    for c = 2:length(carrinhos)
        car = [];
        if ~ismissing(carrinhos{c,:})
            car(end+1) =
        end
        idx = ~ismissing(string(carrinhos(c,:)));
        distJ = intersect(carrinhos(c,:), carrinho)/union(carrinhos(c,:), carrinho);
    end
    %}
end

