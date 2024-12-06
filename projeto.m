h = waitbar(0, 'A ler os produtos...', 'Name', 'A processar dados (Por favor espere)');

%% Leitura dos data-sets
dados_produtos = readcell("produtos_simplified.csv");
waitbar(1/6, h, 'A ler os carrinhos...');
carrinhos = readcell("carrinhos_simplified.csv");
waitbar(2/6, h, 'A atribuir classes aos produtos...');
%% Parse dos dados
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
[classes_produto, probsSEM, probsFIMSEM] = calcProbCaract(produtos, classes, caracteristicas,h);

% Cria uma matriz com o produto e a sua classe respetiva
prod_class_matrix = [caracteristicas classes_produto];
product_prob = [probsSEM probsFIMSEM];

% Criação da matriz Treino (talvez não seja preciso, pois as nossas
% P(car_i|classe) já é retirada automaticamente pelas caracteristicas
Treino = treino(carrinhos, caracteristicas,h);
Classes_carrinho = classificar(carrinhos, caracteristicas, product_prob2, h);
delete(h)

%% Probabilidades das classes: "SEMANA" e "FIM DE SEMANA"
prob_sem = sum(classes == 'SEMANA')/length(classes);     % P('SEMANA')
prob_fimsem = sum(classes == 'FIM DE SEMANA')/length(classes);     % P('FIM DE SEMANA')
fprintf("\nProbabilidades de cada classe:\nP('SEMANA') = %.4f\nP('FIM SEMANA') = %.4f\n", prob_sem, prob_fimsem);

%% Inicializar Bloom Filter
BF = inicializarBF(5000);   % 5000 é só um valor atoa (possivelmente a alterar depois)

%% Pedir input ao utilizador
itensCarrinho = 0;
carrinho = cell();
recomendacoes = cell();

while itensCarrinho ~= 50
    fprintf("Itens: %d/50\n\n1 - Adicionar Item\n2 - Sair\n\n", itensCarrinho);
    opt = input("Opção -> ");
    switch opt
        case 1  % Processo de adicionar item ao carrinho (e atualização das recomendações)
            fprintf("Recomendações:\n");
            mostrar_recomendacoes();
            produto = input("Produto -> ", "s");
            if ~ismember(caracteristicas, produto)
                fprintf("Produto não encontrado!\n");
            elseif verificarBF(elemento, BF, k)
                fprintf("Produto já adicionado!");
            else
                itensCarrinho = itensCarrinho+1;
                recomendacoes = atualizar_recomendacoes(carrinho);
            end
            
        case 2  % Termina a execução do programa
            disp("<strong>Exiting...</strong>");
            return

        otherwise
            fprintf("<strong>Opção inválida!</strong>\n");
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


