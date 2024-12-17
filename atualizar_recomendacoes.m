function recomendacoes = atualizar_recomendacoes(carrinho, BF, k, caracteristicas, product_prob, prob_sem, prob_fimsem, freq)
    % <strong>USAGE: atualizar_recomendacoes</strong>
    % Atualiza as recomendações com base nos produtos que estão atualmente no carrinho
    %
    % <strong>Input:</strong>
    % <strong>carrinho</strong> - Carrinho atual do utilizador
    % <strong>BF</strong> - Bloom Filter
    % <strong>k</strong> - Número de funções de hash
    % <strong>caracteristicas</strong> - Todos os tipos únicos de produtos do dataset
    % <strong>product_prob</strong> - Matriz com 2 colunas: P(Característica|"SEMANA") e P(Característica|"FIM DE SEMANA")
    % <strong>prob_sem</strong> - P("SEMANA")
    % <strong>prob_fimsem</strong> - P("FIM DE SEMANA")
    % <strong>freq</strong> - Número de vezes que cada produto foi vendido
    %
    % <strong>Output:</strong>
    % <strong>recomendacoes</strong> - 10 produtos mais adequados a serem recomendados

    classe_carrinho = bayes_classificar_carrinho(carrinho, caracteristicas, product_prob, prob_sem, prob_fimsem);

    % Falta fazer a verificação do item do carrinho no BF (não se deve recomendar items que já estão no carrinho)
    if strcmp(classe_carrinho, "SEMANA")
        [~, idx] = sort(product_prob(:,1), 'descend');

    elseif strcmp(classe_carrinho, "FIM DE SEMANA")
        [~, idx] = sort(product_prob(:,2), 'descend');

    else    % classe = "N/A"
        [~, idx] = sort(freq(:), 'descend');
    end

    % Verifica se o produto a recomendar existe no carrinho ou não, se já
    % existir, então passa para a próxima recomendação
    recomendacoes = cell(10, 1);
    total = 1;
    c = 1;
    while total ~= 11
        if ~BF_verificar(caracteristicas{idx(c), 1}, BF, k)
            recomendacoes{total, 1} = caracteristicas(idx(c));
            total = total+1;
        end
        c = c+1;
    end
end

