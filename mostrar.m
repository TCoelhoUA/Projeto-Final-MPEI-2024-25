function mostrar(recomendacoes, carrinho, itens_similares, itens_carrinho)
    fprintf("<strong>Recomendações:</strong>\n");
    for r = 1:length(recomendacoes)
        fprintf("• %s\n", recomendacoes{r}{1});
    end

    max_idx = 10;
    if length(itens_similares) < 10
        max_idx = length(itens_similares);
    end
    fprintf("\n<strong>Outros utilizadores também compraram:</strong>\n");
    for i = 1:max_idx
        fprintf("• %s\n", itens_similares(i));
    end
    

    fprintf("\n<strong>Carrinho:</strong>\n");
    p = 1;
    while ~ismissing(carrinho{p, 1})
        fprintf("• %s\n", carrinho{p, 1});
        p = p+1;
    end
    fprintf("\nItens: %d/11\n\n", itens_carrinho)
end

