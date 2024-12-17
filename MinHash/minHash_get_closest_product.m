function closestProducts =  minHash_get_closest_product(similarities, products)
%minHash_get_closest_product Retorna os produtos organizados por ordem decrescente
%de similaridade
%   Input:
%       similatiries    - array com as similaridades de cada produto
%       produtcs        - array o nome de cada produto
%   <strong>NOTA: </strong> similarities e products têm de ter o mesmo tamanho e, para
%   funcionar corretamente, cada indice de similarities tem de corresponder
%   ao produto do mesmo indice em products!
%   Output:
%       closestProducts - array de products, em formato string, organizado
%       por ordem decrescente de similaridade

    [~, sorted_indices] = sort(similarities, 'descend');
    closestProducts = string(products(sorted_indices(:)));
end