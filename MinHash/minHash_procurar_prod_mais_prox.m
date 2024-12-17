function closest_products = minHash_procurar_prod_mais_prox(produto, ks, nhf, R, p, MA_produtos, caracteristicas)
    % <strong>USAGE: minHash_procurar_prod_mais_prox(produto, ks, nhf, R, p, MA_produtos, caracteristicas)</strong>
    % Devolve os produtos por ordem decrescende de similaridade a um
    % produto expecifico, utilizando uma abordagem minHash
    %
    % <strong>Input:</strong>
    % <strong>produto</strong> - Produto que foi escrito pelo utilizador
    % <strong>ks</strong> - Tamanho dos shingles
    % <strong>nhf</strong> - Número de hash functions
    % <strong>R</strong> - Matriz aleatória
    % <strong>p</strong> - Número primo
    % <strong>MA_produtos</strong> - Matriz assinatura mxn com n produtos por m funções hash
    % <strong>caracteristicas</strong> - Todos os tipos únicos de produtos do dataset
    %
    % <strong>Output:</strong>
    % <strong>closest_products</strong> - Array com as caracterisicas mais próximas de produto por ordem decrescente

    shingles_string = minHash_gerar_shingles_string(produto, ks);
    assinaturas = minHash_calcular_assinaturas_string(shingles_string, nhf, R, p);
    similaridades = minHash_calcular_similaridades(assinaturas, MA_produtos);
    closest_products = minHash_get_closest_product(similaridades, caracteristicas);
end