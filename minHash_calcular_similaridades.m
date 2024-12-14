function similarities = minHash_calcular_similaridades(assinatura,MA)
%minHash_calcular_similaridades Calcula a similaridade de um produto em relação a
%uma matriz assinatura com todos os produtos
%   Input:
%       assinatura  -   array 1xn com as assinatura da string em n hash_functions
%       MA          -   matriz assinatura mxn com m hash_functions e n produtos
%   Output:
%       similarities -  array com as similaridades da string a cada produto

    n_products = size(MA, 2);
    similarities = zeros(1, n_products);
    for i = 1:n_products
        similarities(i) = sum(assinatura == MA(:, i)) / length(Signature);
    end
end