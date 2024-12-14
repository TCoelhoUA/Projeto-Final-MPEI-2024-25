function [carrinhos_similares, idx] = atualizar_carrinhos_similares(carrinho, carrinhos)
    % <strong>USAGE: atualizar_carrinhos_similares</strong>
    % Atualiza os 5 carrinhos mais similares ao carrinho atual do utilizador
    %
    % <strong>Input:</strong>
    % <strong>carrinho</strong> - Carrinho do utilizador
    % <strong>carrinhos</strong> - Todos os carrinhos do dataset
    %
    % <strong>Output:</strong>
    % <strong>carrinhos_similares</strong> - 5 carrinhos mais similares por ordem decrescente
    % <strong>idx</strong> - Índices dos 5 carrinhos mais similares por ordem decrescente

    distancias = distJ(carrinho, carrinhos);

    [~, idx] = maxk(distancias,5);  % 5 carrinhos mais similares
    idx = idx+1;    % ignora a linha inicial de 'carrinhos' que contém números de 0 a 10
    carrinhos_similares = cell(5, 11);
    disp(carrinhos_similares)
    carrinhos_similares(:) = '';
    for i = 1:5
        for item = 1:11
            if ~ismissing(carrinhos{idx(i), item})
                carrinhos_similares{i, item} = carrinhos{idx(i), item};
            end
        end
    end
    disp(carrinhos_similares)
    disp(idx)
end

