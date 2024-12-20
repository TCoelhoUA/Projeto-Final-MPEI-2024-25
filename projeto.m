%% Leitura  e interpretação dos datasets
h = waitbar(0, 'A ler os produtos...', 'Name', 'A processar dados (Por favor espere)');
dados_produtos = readcell("produtos_simplified.csv");  % dataset simplificado (para demonstração)
%dados_produtos = readcell("produtos.csv");  % dataset original (para uso final)

%% Parse dos dados
waitbar(1/6, h, 'A atribuir classes aos produtos...');
produtos = string(dados_produtos(2:end, 3));
produtos_e_datas = string(dados_produtos(2:end, 2:3));               % Vetor com os vários produtos comprados e as datas (separadamente)
caracteristicas = unique(produtos);                % Vetor com os tipos distintos de produtos

[carrinhos, h] = criar_carrinhos(produtos_e_datas, h);

% Permutação aleatória (90% treino, 10% teste)

permutacao = randperm(length(carrinhos));
idx_treino = round(90/100 * length(carrinhos));
carrinhos_todos = carrinhos;
carrinhos_teste = carrinhos(permutacao(idx_treino+1:end));
carrinhos = carrinhos(permutacao(1:idx_treino));

%% Cálculo das probabilidades de cada classe
% Probabilidades das classes: "SEMANA" e "FIM DE SEMANA"
prob_sem = 0;
prob_fimsem = 0;
for car = 1:numel(carrinhos)
    if strcmp(carrinhos{car}{1}, 'SEMANA')
        prob_sem = prob_sem + 1;
    else
        prob_fimsem = prob_fimsem + 1;
    end
    waitbar(2/6+1/6*car/numel(carrinhos), h, 'A atribuir classes aos produtos...');
end
prob_sem = prob_sem/numel(carrinhos);
prob_fimsem = prob_fimsem/numel(carrinhos);

%% Cálculo das probabilidades de cada característica sabendo a classe
% P(característica|classe)
[product_prob, freq, h] = bayes_calculo_prob_caract(carrinhos, caracteristicas, h);

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
[MA_produtos, h] = minHash_calcular_assinaturas(shingles, nhf, R, p, h);
delete(h);

%% Interface -Inicialização do Bloom Filter e input do utilizador
% Inicializar Bloom Filter e agregados
BF = BF_inicializar(400);
k_bloom = 3;  % numero de funcoes de hash


% Aplicação conjunta
% Pedir input ao utilizador
clc;    % limpa o terminal
itens_carrinho = 0;
carrinho = cell(25, 1);
carrinho(:) = {''};
recomendacoes = cell(10, 1);    % possivelmente inicializar como um cell array dos produtos mais comprados
                                % sem interessar a classe, apenas como recomendação inicial ou quando
                                % classe = "N/A"

while itens_carrinho < numel(carrinho)
    fprintf("Itens: %d/%d\n\n<strong>1</strong> - Adicionar Item\n<strong>2</strong> - Sair\n\n", itens_carrinho, numel(carrinho));
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
            carrinhos_similares = atualizar_carrinhos_similares(carrinho, carrinhos);
            itens_similares = unique(carrinhos_similares);
            mostrar(recomendacoes, carrinho, itens_similares, BF, k_bloom, itens_carrinho);
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