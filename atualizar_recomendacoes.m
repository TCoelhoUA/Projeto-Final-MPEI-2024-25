function recomendacoes = atualizar_recomendacoes(recomendacoes, carrinho, BF, k, caracteristicas, product_prob, FREQ)
    % Esta função atualiza as recomendações com base nos produtos
    % que estão atualmente no carrinho
    %
    % Input:
    % carrinho - cell array com os produtos adicionados
    % probsSEM - probabilidades de cada produto ser comprado durante a semana
    % probsFIMSEM - probabilidades de cada produto ser comprado durante o fim de semana
    %
    % Output:
    % recomendacoes - recomendações atualizadas

    classe_carrinho = classificar_carrinho(carrinho, caracteristicas, product_prob);

    % Falta fazer a verificação do item do carrinho no BF (não se deve recomendar items que já estão no carrinho)
    if strcmp(classe_carrinho, "SEMANA")
        [~, idx] = sort(product_prob(:,1), 'descend');
        %[sorted, idx] = sort(product_prob(:,1), 'descend');
        %sorted = sort(product_prob(:,1), 'descend');
    elseif strcmp(classe_carrinho, "FIM DE SEMANA")
        [~, idx] = sort(product_prob(:,2), 'descend');
        %[sorted, idx] = sort(product_prob(:,2), 'descend');
        %sorted = sort(product_prob(:,2), 'descend');
    else    % classe = "N/A"
        [~, idx] = sort(FREQ(:), 'descend');
    end

    % Verifica se o produto a recomendar existe no carrinho ou não, se já
    % existir, então passa para a próxima recomendação
    recomendacoes = cell(10, 1);
    total = 1;
    c = 1;
    while total ~= 11
        if ~verificarBF(caracteristicas{idx(c), 1}, BF, k)
            recomendacoes{total, 1} = caracteristicas(idx(c));
            total = total+1;
        end
        c = c+1;
    end
end

