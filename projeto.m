%% Leitura dos data-sets
h = waitbar(0, 'A ler os produtos...', 'Name', 'A processar dados (Por favor espere)');
dados_produtos = readcell("produtos_simplified.csv");

waitbar(1/6, h, 'A ler os carrinhos...');
carrinhos = readcell("carrinhos_simplified.csv");

%% Parse dos dados
waitbar(2/6, h, 'A atribuir classes aos produtos...');
produtos = dados_produtos(2:end, 3);               % Vetor com os vários produtos comprados (separadamente)
caracteristicas = unique(produtos);                % Vetor com os tipos distintos de produtos

classes_numericas = cell2mat(dados_produtos(2:end,7));    % Vetor com as classes associadas a cada compra de produto individual

% Atribuição das classes 'SEMANA' e 'FIM DE SEMANA'
% Semana - Segunda a Sexta (0:4)
% Fim de semana - Sábado e Domingo (5:6)

classes = cell(size(classes_numericas)); % Cria uma célula do mesmo tamanho de 'classes_numericas'
classes(classes_numericas >= 0 & classes_numericas <= 4) = {'SEMANA'};
classes(classes_numericas >= 5 & classes_numericas <= 6) = {'FIM DE SEMANA'};
classes = categorical(classes);

% Associa cada produto a uma classe
[classes_produto, product_prob, FREQ] = calcProbCaract(produtos, classes, caracteristicas,h);


classes_produto_cell = cellstr(classes_produto);

% Cria uma matriz com o produto, a sua classe respetiva e as suas
% probabilidades
product_class_probs_matrix = [caracteristicas(:), classes_produto_cell(:), num2cell(product_prob), num2cell(FREQ)];

% Criação da matriz Treino (talvez não seja preciso, pois as nossas
% P(car_i|classe) já é retirada automaticamente pelas caracteristicas
Treino = treino(carrinhos, caracteristicas,h);
%Classes_carrinho = classificar(carrinhos, caracteristicas, product_prob2, h);
delete(h)

%% Probabilidades das classes: "SEMANA" e "FIM DE SEMANA"
prob_sem = sum(classes == 'SEMANA')/length(classes);     % P('SEMANA')
prob_fimsem = sum(classes == 'FIM DE SEMANA')/length(classes);     % P('FIM DE SEMANA')
fprintf("\nProbabilidades de cada classe:\nP('SEMANA') = %.4f\nP('FIM SEMANA') = %.4f\n", prob_sem, prob_fimsem);

%% Gerar shingles e assinaturas

% Shingles
ks = 3; % 2-shingles
shingles = gerar_shingles(caracteristicas, ks);

% Assinaturas
nhf = 200;
p = 1234567;
while ~isprime(p)
    p = p+2;
end
R = randi(p, nhf, ks);
MA_produtos = calcular_assinaturas(shingles, nhf, R, p);

%% Inicializar Bloom Filter e agregados
BF = inicializarBF(5000);   % 5000 é só um valor aleatório (possivelmente a alterar depois)
k = 3;  % numero de funcoes de hash
% Adaptado de 'Symbolic Math Toolbox'
%range = [1 999999];
%p = nthprime(randi(range));
% -------------------------

%% Pedir input ao utilizador
clc;    % limpa o terminal
itensCarrinho = 0;
carrinho = cell(50, 1);
recomendacoes = cell(10, 1);    % possivelmente inicializar como um cell array dos produtos mais comprados
                                % sem interessar a classe, apenas como recomendação inicial ou quando
                                % classe = "N/A"

while itensCarrinho ~= 50
    fprintf("Itens: %d/50\n\n<strong>1</strong> - Adicionar Item\n<strong>2</strong> - Sair\n\n", itensCarrinho);
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
            recomendacoes = atualizar_recomendacoes(recomendacoes, carrinho, BF, k, caracteristicas, product_prob, FREQ);
            mostrar(recomendacoes, carrinho, itensCarrinho);
            produto = input("<strong>Produto -> </strong>", "s");
            clc;    % limpa o terminal

            if ~ismember(produto, caracteristicas)
                fprintf("<strong>Produto não encontrado!</strong>\n");
                closest_products = procurar_prod_mais_prox(produto, ks, nhf, R, p, MA_produtos, caracteristicas);
                i = 1;
                while verificarBF(char(closest_products(i)), BF, k)
                    i = i+1; %ignora os produtos que já estão no carrinho;
                end
                available_closestProduct = char(closest_products(i));
                while 1
                    fprintf("Será que quiz dizer: %s?\n", available_closestProduct);
                    fprintf("<strong>1</strong> - Sim\n<strong>2</strong> - Não\n\n");
                    opt2 = input("<strong>Opção -> </strong>", "s");
                    clc;
                    if ~ismember(opt2, {'1', '2'})
                        fprintf("<strong>Opção inválida!</strong>\n\n");
                        continue;
                    end
                    opt2 = str2double(opt2);
                    switch opt2
                        case 1
                            [carrinho, itensCarrinho, BF] = adicionar_ao_carrinho(available_closestProduct, BF, k, carrinho, itensCarrinho);
                    end
                    break;
                end

            elseif verificarBF(produto, BF, k)
                fprintf("<strong>Produto já adicionado!</strong>\n");

            else
                [carrinho, itensCarrinho, BF] = adicionar_ao_carrinho(produto, BF, k, carrinho, itensCarrinho);
            end
            
        case 2  % Termina a execução do programa
            disp("<strong>Exiting...</strong>");
            return
    end
end

%% TESTE 1 - Dá print dos produtos e quando se vendem mais (semana ou fim de semana, proporcional ao dias: 5 e 2)
%produtos = categorical(dados_produtos(2:end, 3));
for i=1:length(caracteristicas)
    sem = 0;
    fimsem = 0;
    for n=1:length(produtos)
        if ismember(produtos{n, 1}, caracteristicas(i, 1))
            if classes(n, 1) == 'SEMANA'
                sem = sem+1/5;
            else
                fimsem = fimsem+1/2;
            end
        end
    end
    if sem > fimsem
        fprintf("%s é mais SEMANA (%d | %d)\n", caracteristicas{i, 1});
    else
        fprintf("%s é mais FIM DE SEMANA (%d | %d)\n", caracteristicas{i, 1});
    end
end

%% Teste 2
fprintf("%d - %d", probsSEM(2), probsFIMSEM(2));
c=0;
for i=1:length(probsSEM)
    if ((probsSEM(i) == 0 && probsFIMSEM(i) ~= 0) || (probsSEM(i) ~= 0 && probsFIMSEM(i) == 0))
        fprintf("%d\n", i);
        c=c+1;
    end
end

%% Teste 3


