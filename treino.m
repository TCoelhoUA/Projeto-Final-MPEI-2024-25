function Treino = treino(carrinhos, caracteristicas, h)
    % A função 'cellTreino' cria uma matriz binária do tipo tabela onde marca
    % com 1 sempre que uma caracteristica se verificar.
    %
    % Exemplo:
    %      _______________
    %    _|ca1|ca2|ca3|ca4|
    %   |1| 0 | 1 | 1 | 0 |         Sendo:
    %   |2| 1 | 1 | 0 | 0 |         - 1, 2, 3 e 4 'carrinhos'           (elementos)
    %   |3| 1 | 0 | 0 | 1 |         - ca1, ca2, ca3 e ca4 'produtos'    (características)
    %   |4| 0 | 1 | 1 | 1 |
    %    ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
    % Input:
    % cell - um cell array com linhas (carrinhos), com os produtos que
    % contém, separados por vírgulas.
    % caracteristicas - vetor com todas as características (produtos)
    % únicas a considerar.
    %
    % Output:
    % Treino - uma matriz binária como descrito acima exceto sem a coluna e
    % linha de elemntos e características.

    Treino = zeros(size(carrinhos, 1)-1,size(caracteristicas, 1), 'uint8');

    for produto = 1:length(caracteristicas)
        for carro = 2:size(Treino, 1)
            for item_number = 1:size(carrinhos, 2)
                if ~ismissing(carrinhos{carro, item_number}) % Se não estiver <missing>
                    if ismember(carrinhos{carro, item_number}, caracteristicas(produto))
                        Treino(carro-1, produto) = 1;
                    end
                else                            % Caso contrário saltamos de carrinho (o atual já terminou)
                    break
                end
            end
        end
        waitbar(3/6+1/6*((produto-1)/length(caracteristicas)), h, 'A criar uma matriz de treino...');
    end
end

