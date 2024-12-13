function [carrinho, itens_carrinho, BF] = adicionar_ao_carrinho(produto, BF, k, carrinho, itens_carrinho)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    BF = adicionarBF(produto, BF, k);
    itens_carrinho = itens_carrinho+1;
    carrinho{itens_carrinho, 1} = produto;
end