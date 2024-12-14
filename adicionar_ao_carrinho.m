function [carrinho, itens_carrinho, BF] = adicionar_ao_carrinho(produto, BF, k, carrinho, itens_carrinho)
    % <strong>USAGE: adicionar_ao_carrinho</strong>
    % Adiciona um produto a um carrinho através de um Bloom Filter.
    %
    % <strong>Input:</strong>
    % <strong>produto</strong> - Produto a adicionar (string)
    % <strong>BF</strong> - Bloom Filter
    % <strong>k</strong> - Número de hash functions
    % <strong>carrinho</strong> - Carrinho onde adicionar produto
    % <strong>itens_carrinho</strong> - Número de itens no carrinho
    %
    % <strong>Output:</strong>
    % <strong>carrinho</strong> - Carrinho com o produto adicionado
    % <strong>itens_carrinho</strong> - Número de itens no carrinho
    % <strong>BF</strong> - Bloom Filter atualizado

    BF = BF_adicionar(produto, BF, k);
    itens_carrinho = itens_carrinho+1;
    carrinho{itens_carrinho, 1} = produto;
end