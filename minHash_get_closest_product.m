function closestProducts =  minHash_get_closest_product(similarities, products)
%USAGE:minHash_get_closest_product(similarities, products)
% Retorna os produtos organizados por ordem decrescente de similaridade
% <strong>Input:</strong>
% <strong>similatiries</strong> - array com as similaridades de cada produto
% <strong>produtcs</strong> - array o nome de cada produto
%      <strong>NOTA:</strong> similarities e products têm de ter o mesmo tamanho e, para
%   funcionar corretamente, cada indice de similarities tem de corresponder
%   ao produto do mesmo indice em products!
%
% <strong>Output:</strong>
% <strong>closestProducts</strong> - array de products, em formato string, organizado
% por ordem decrescente de similaridade

    [~, sorted_indices] = sort(similarities, 'descend');
    closestProducts = string(products(sorted_indices(:)));
end