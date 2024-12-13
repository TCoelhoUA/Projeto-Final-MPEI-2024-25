function closest_products = procurar_prod_mais_prox(produto, ks, nhf, R, p, MA_produtos, caracteristicas)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    shingles_string = create_shingles_string(produto, ks);
    assinaturas = calc_assinaturas_minHash_string(shingles_string, nhf, R, p);
    similaridades = calcular_similaridades(assinaturas, MA_produtos);
    closest_products = get_closest_product(similaridades, caracteristicas);
end