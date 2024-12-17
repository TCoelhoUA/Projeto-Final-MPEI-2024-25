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

    [~, idx] = sort(distancias, 'descend');  % carrinhos organizados por similaridade
    %idx = idx+1;    % ignora a linha inicial de 'carrinhos' que contém números de 0 a 10
    %carrinhos_similares = cell(5, 11);
    %carrinhos_similares(:) = '';
    carrinhos_similares = [];

    count = 1; %contador para número de carrinhos válidos a serem recomendados
    for i = 1:length(idx)

        if count > 5
            break; %termina quando existem 5 carrinhos válidos
        end
        
        carrinho_candidato = carrinhos{idx(i)}(3:end);

        if any(~ismember(carrinho_candidato, carrinho))
            count = count + 1;
            carrinhos_similares = [carrinhos_similares carrinho_candidato];
        end
    end
end

