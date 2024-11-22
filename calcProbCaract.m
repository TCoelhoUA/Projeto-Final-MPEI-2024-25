function classes_produto = calcProbCaract(produtos, classes, caracteristicas)
%Associa uma classe a cada produto
%   produtos:   - CellArray com os produtos(incluindo os repetidos)
%   classes:    - CellArray com as classes(SEMANA e FIMDESEMANA),
%   associados ao array "produtos"
%   caracteristicas - CellArray com os produtos não repetidos
    classes_produto = categorical(zeros(size(caracteristicas, 1),1));
    
    for caracteristica=1:length(caracteristicas)
        s = 0;
        fs = 0;
        frequency = 0; % frequencia do produto

        for produto=1:length(produtos)
            if strcmp(produtos{produto}, caracteristicas{caracteristica})
                frequency = frequency + 1;
                if (classes(produto) == "SEMANA")
                    s = s+1/5; %para compensar haver mais dias da semana
                else
                    fs = fs+1/2;
                end
            end
        end
        if (frequency == 0)
            classes_produto(caracteristica) = 'N/A';
            break;
        end
        if (s/frequency > fs/frequency)
            classes_produto(caracteristica) = 'SEMANA';
        else
            classes_produto(caracteristica) = 'FIM DE SEMANA';
        end
    end
end