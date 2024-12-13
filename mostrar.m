function mostrar(recomendacoes, carrinho, carrinhos_similares, itens_carrinho)
    fprintf("<strong>Recomendações:</strong>\n");
    for r = 1:length(recomendacoes)
        fprintf("• %s\n", recomendacoes{r}{1});
    end
    
    %{  
    Recomendações por MinHash
    Supostamente quando o programa corre 'carrinhos_similares' fica um 5x4
    cell mas eu iniciei-o como um 5x11 nao percebo o porque de ficar 5x4
    entao desativei temporariamente este print

    fprintf("<strong>\nOutros utilizadores também compraram:</strong>\n");
    for cs = 1:length(carrinhos_similares)
        p = 1;
        while ~missing(carrinhos_similares{cs, p})
            fprintf("• %s\n", carrinhos_similares{cs, p});
            p = p+1;
        end
    end
    %}

    fprintf("\n<strong>Carrinho:</strong>\n");
    p = 1;
    while ~ismissing(carrinho{p, 1})
        fprintf("• %s\n", carrinho{p, 1});
        p = p+1;
    end
    fprintf("\nItens: %d/50\n\n", itens_carrinho)
end

