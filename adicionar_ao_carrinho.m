function [carrinho, itensCarrinho, BF] = adicionar_ao_carrinho(produto, BF, k, carrinho, itensCarrinho)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    BF = adicionarBF(produto, BF, k);
    itensCarrinho = itensCarrinho+1;
    carrinho{itensCarrinho, 1} = produto;
end