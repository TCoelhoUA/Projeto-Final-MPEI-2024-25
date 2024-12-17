function similarities = minHash_calcular_similaridades(assinatura,MA)
%USAGE: minHash_calcular_similaridades(assinatura,MA)
% Calcula a similaridade de um produto em relação a uma matriz assinatura com todos os produtos
% <strong>Input:</strong>
% <strong>assinatura</strong> - array 1xn com as assinatura da string em n hash_functions
% <strong>MA</strong> - matriz assinatura mxn com m hash_functions e n produtos
% 
% <strong>Output:</strong>
% <strong>similarities</strong> -  array com as similaridades da string a cada produto

    n_products = size(MA, 2);
    similarities = zeros(1, n_products);
    for i = 1:n_products
        similarities(i) = sum(assinatura == MA(:, i)) / length(assinatura);
    end
end