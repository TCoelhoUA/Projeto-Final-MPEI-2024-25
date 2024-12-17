function mostrar(recomendacoes, carrinho, itens_similares, BF, k_bloom, itens_carrinho)
    % Recomendações (Naïve Bayes)
    fprintf("<strong>Recomendações:</strong>\n");
    for r = 1:length(recomendacoes)
        fprintf("• %s\n", recomendacoes{r}{1});
    end

    % Recomendações (MinHash)
    c = 1;
    item = 1;
    fprintf("\n<strong>Outros utilizadores também compraram:</strong>\n");
    while c ~= 11 && item ~= length(itens_similares)
        if ~BF_verificar(char(itens_similares(item)), BF, k_bloom)
            fprintf("• %s\n", itens_similares(item));
            c = c+1;
        end
        item = item + 1;
    end
    
    % Carrinho do utilizador
    fprintf("\n<strong>Carrinho:</strong>\n");
    p = 1;
    while ~ismissing(carrinho{p, 1})
        fprintf("• %s\n", carrinho{p, 1});
        p = p+1;
    end
    fprintf("\nItens: %d/%d\n\n", itens_carrinho, length(carrinho))
end

