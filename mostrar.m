function mostrar(recomendacoes, carrinho, itensCarrinho)
    fprintf("<strong>Recomendações:</strong>\n");
    for r = 1:length(recomendacoes)
        fprintf("• %s\n", recomendacoes{r}{1});
    end

    fprintf("\n<strong>Carrinho:</strong>\n");
    p = 1;
    while ~ismissing(carrinho{p, 1})
        fprintf("• %s\n", carrinho{p, 1});
        p = p+1;
    end
    fprintf("\nItens: %d/50\n\n", itensCarrinho)
end

