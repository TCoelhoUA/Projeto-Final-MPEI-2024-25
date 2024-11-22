function Treino = treino(carrinhos, caracteristicas)
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

    for car = 1:length(caracteristicas)
        for line = 2:size(Treino, 1)
            for col = 1:size(carrinhos, 2)
                if ~ismissing(carrinhos{line, col}) % Se não estiver <missing>
                    if ismember(carrinhos{line, col}, caracteristicas(car))
                        Treino(line-1, car) = 1;
                    else                            % Caso contrário saltamos de carrinho (o atual já terminou)
                        break
                    end
                end
            end
        end
    end
end

