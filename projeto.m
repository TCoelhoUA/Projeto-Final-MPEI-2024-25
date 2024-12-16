%% Leitura  e interpretação dos datasets
h = waitbar(0, 'A ler os produtos...', 'Name', 'A processar dados (Por favor espere)');
dados_produtos = readcell("produtos_simplified.csv");  % dataset simplificado (para demonstração)
%dados_produtos = readcell("produtos.csv");  % dataset original (para uso final)

waitbar(1/6, h, 'A ler os carrinhos...');
carrinhos = readcell("carrinhos_simplified.csv");  % dataset simplificado (para demonstração)
%carrinhos = readcell("carrinhos.csv");  % dataset original (para uso final)

%% Parse dos dados
waitbar(2/6, h, 'A atribuir classes aos produtos...');
produtos = dados_produtos(2:end, 3);               % Vetor com os vários produtos comprados (separadamente)
caracteristicas = unique(produtos);                % Vetor com os tipos distintos de produtos

classes_numericas = cell2mat(dados_produtos(2:end,7));    % Vetor com as classes associadas a cada compra de produto individual

%% Atribuição das classes 'SEMANA' e 'FIM DE SEMANA'
% Semana - Segunda a Sexta (0:4)
% Fim de semana - Sábado e Domingo (5:6)

classes = cell(size(classes_numericas)); % Cria uma célula do mesmo tamanho de 'classes_numericas'
classes(classes_numericas >= 0 & classes_numericas <= 4) = {'SEMANA'};
classes(classes_numericas >= 5 & classes_numericas <= 6) = {'FIM DE SEMANA'};
classes = categorical(classes);

% Associa cada produto a uma classe
[classes_produto, product_prob, freq] = bayes_calculo_prob_caract(produtos, classes, caracteristicas, h);


classes_produto_cell = cellstr(classes_produto);

% Cria uma matriz com os produtos, as suas classes respetivas, as suas
% probabilidades e as suas frequências
product_class_probs_matrix = [caracteristicas(:), classes_produto_cell(:), num2cell(product_prob), num2cell(freq)];

% Criação da matriz Treino (talvez não seja preciso, pois as nossas
% P(car_i|classe) já é retirada automaticamente pelas caracteristicas
Treino = treino(carrinhos, caracteristicas, h);
%Classes_carrinho = bayes_classificar(carrinhos, caracteristicas, product_prob2, h);
delete(h)

% Probabilidades das classes: "SEMANA" e "FIM DE SEMANA"
prob_sem = sum(classes == 'SEMANA')/length(classes);     % P('SEMANA')
prob_fimsem = sum(classes == 'FIM DE SEMANA')/length(classes);     % P('FIM DE SEMANA')
fprintf("\nProbabilidades de cada classe:\nP('SEMANA') = %.4f\nP('FIM SEMANA') = %.4f\n", prob_sem, prob_fimsem);

%% Gerar shingles e assinaturas

% Shingles
ks = 2; % 2-shingles
shingles = minHash_gerar_shingles(caracteristicas, ks);

% Assinaturas
nhf = 200;
p = 1234567;
while ~isprime(p)
    p = p+2;
end
R = randi(p, nhf, ks);
MA_produtos = minHash_calcular_assinaturas(shingles, nhf, R, p);

%% Interface -Inicialização do Bloom Filter e input do utilizador
% Inicializar Bloom Filter e agregados
BF = BF_inicializar(150);   % 5000 é só um valor aleatório (possivelmente a alterar depois)
k_bloom = 3;  % numero de funcoes de hash

% Pedir input ao utilizador
clc;    % limpa o terminal
itens_carrinho = 0;
car_size = 11;
carrinho = cell(car_size, 1);
carrinho(:) = {''};
recomendacoes = cell(10, 1);    % possivelmente inicializar como um cell array dos produtos mais comprados
                                % sem interessar a classe, apenas como recomendação inicial ou quando
                                % classe = "N/A"

while itens_carrinho < car_size
    fprintf("Itens: %d/%d\n\n<strong>1</strong> - Adicionar Item\n<strong>2</strong> - Sair\n\n", itens_carrinho, car_size);
    opt = input("<strong>Opção -> </strong>", "s");
    clc;    % limpa o terminal

    % Validar input
    if ~ismember(opt, {'1', '2'})
        fprintf("<strong>Opção inválida!</strong>\n\n");
        continue;
    end

    opt = str2double(opt);
    switch opt
        case 1  % Processo de adicionar item ao carrinho (e atualização das recomendações)
            recomendacoes = atualizar_recomendacoes(carrinho, BF, k_bloom, caracteristicas, product_prob, prob_sem, prob_fimsem, freq);
            carrinhos_similares = atualizar_carrinhos_similares(carrinho, carrinhos, car_size);
            mostrar(recomendacoes, carrinho, carrinhos_similares, itens_carrinho);
            produto = input("<strong>Produto -> </strong>", "s");
            clc;    % limpa o terminal

            if ~ismember(produto, caracteristicas)
                fprintf("<strong>Produto não encontrado!</strong>\n");
                if length(produto) >= ks    % se o nº de caracteres for maior ou igual  do que o tamanho
                                            % dos shingles, então recomenda-se uma correção de produto
                    closest_products = minHash_procurar_prod_mais_prox(produto, ks, nhf, R, p, MA_produtos, caracteristicas);
                    i = 1;
                    while BF_verificar(char(closest_products(i)), BF, k_bloom)
                        i = i+1; %ignora os produtos que já estão no carrinho;
                    end
                    closest_product = char(closest_products(i));
                    while 1
                        fprintf("\nSerá que quiz dizer <strong>%s</strong>?\n", closest_product);
                        fprintf("\n<strong>1</strong> - Sim\n<strong>2</strong> - Não\n\n");
                        opt2 = input("<strong>Opção -> </strong>", "s");
                        clc;
                        if ~ismember(opt2, {'1', '2'})
                            fprintf("<strong>Opção inválida!</strong>\n");
                            continue;
                        end
                        opt2 = str2double(opt2);
                        switch opt2
                            case 1
                                [carrinho, itens_carrinho, BF] = adicionar_ao_carrinho(closest_product, BF, k_bloom, carrinho, itens_carrinho);
                        end
                        break;
                    end
                end
            elseif BF_verificar(produto, BF, k_bloom)
                fprintf("<strong>Produto já adicionado!</strong>\n");

            else
                [carrinho, itens_carrinho, BF] = adicionar_ao_carrinho(produto, BF, k_bloom, carrinho, itens_carrinho);
            end
            
        case 2  % Termina a execução do programa
            
            fprintf("Deseja guardar a sua lista de compras?\n\n<strong>1</strong> - Sim\n<strong>2</strong> - Não\n\n");
            opt = input("<strong>Opção -> </strong>", "s");
            clc;    % limpa o terminal

            if ismember(opt, {'1'})
                guardar_ficheiro(carrinho);
            end
            
            disp("<strong>Exiting...</strong>");
            return
    end
end

fprintf("<strong>O carrinho está cheio!</strong>\n")
fprintf("\nDeseja guardar a sua lista de compras?\n\n<strong>1</strong> - Sim\n<strong>2</strong> - Não\n\n");
opt = input("<strong>Opção -> </strong>", "s");
clc;    % limpa o terminal

if ismember(opt, {'1'})
    guardar_ficheiro(carrinho);
end

disp("<strong>Exiting...</strong>");
return

%% Testes aos módulos
%% Classificador Naïve Bayes
%% Filtro de Bloom
%R = randi(152, 1000, 11);

%carrinho1 = cell(1, 11);
%carrinho2 = cell(1, 11);

k_bloom = 3;

RESULTADOS = zeros(1000, 1);
% 1000 carrinhos, cada um com 11 items
for carrinho = 1:1000
    BF = BF_inicializar(150);

    carrinho_idx = randperm(152, 11);   % escolha aleatória de itens

    for product = 1:11
        BF = BF_adicionar(cell2mat(caracteristicas(carrinho_idx(product))), BF, k_bloom);
    end
    if (sum(BF) ~= 11*k_bloom)
        RESULTADOS(carrinho) = 1;
    end
end

%% MinHash