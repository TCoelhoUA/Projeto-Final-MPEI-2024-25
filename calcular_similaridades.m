function similarities = calcular_similaridades(Signature,MA)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    n_products = size(MA, 2);
    similarities = zeros(1, n_products);
    for i = 1:n_products
        similarities(i) = sum(Signature == MA(:, i)) / length(Signature);
    end
end