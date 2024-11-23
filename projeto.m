%% Leitura dos data-sets
dados_produtos = readcell("produtos_simplified.csv");
carrinhos = readcell("carrinhos_simplified.csv");

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

%associa cada produto a uma classe
classes_produto = calcProbCaract(produtos, classes, caracteristicas);

%Cria uma matriz com o produto e a sua classe
prod_class_matrix = [caracteristicas(:) classes_produto(:)];

% Criação da matriz Treino
Treino = treino(carrinhos, caracteristicas);
[Classes, probsSEM, probsFIMSEM] = classificar(carrinhos, produtos, classes, caracteristicas);
%% Probabilidades das classes: "SEMANA" e "FIM DE SEMANA"
prob_sem = sum(classes == 'SEMANA')/length(classes);     % P('SEMANA')
prob_fimsem = sum(classes == 'FIM DE SEMANA')/length(classes);     % P('FIM DE SEMANA')
fprintf("\nProbabilidades de cada classe:\nP('SEMANA') = %.4f\nP('FIM SEMANA') = %.4f\n", prob_sem, prob_fimsem);

%% TESTE 1 - Dá print dos produtos e quando se vendem mais (semana ou fim de semana, proporcional ao dias: 5 e 2)
%produtos = categorical(dados_produtos(2:end, 3));
for i=1:length(caracteristicas)
    sem = 0;
    fds = 0;
    for n=1:length(produtos)
        if ismember(produtos{n, 1}, caracteristicas(i, 1))
            if classes(n, 1) == 'SEMANA'
                sem = sem+1/5;
            else
                fds = fds+1/2;
            end
        end
    end
    if sem > fds
        fprintf("%s é mais SEMANA (%d | %d)\n", caracteristicas{i, 1});
    else
        fprintf("%s é mais FODASSE (%d | %d)\n", caracteristicas{i, 1});
    end
end

%% Teste 2
fprintf("%d - %d", probsSEM(2), probsFIMSEM(2));
c=0;
for i=1:length(probsSEM)
    if ((probsSEM(i) == 0 & probsFIMSEM(i) ~= 0) || (probsSEM(i) ~= 0 & probsFIMSEM(i) == 0))
        fprintf("%d\n", i);
        c=c+1;
    end
end

%% Teste 3


%% Probabilidade de cada característica sabendo a classe
% Classe = 'SEMANA'
linhas_sem = classes == 'SEMANA';
treino_sem = treino(linhas_sem, :);
contagem = sum(treino_sem);
total = size(treino_sem, 1);
prob_caracteristica_dado_sem = contagem/total;
%linhas_C1 = classes_treino == C1;
%TREINO_C1 = TREINO(linhas_C1, :);

%contagem = sum(TREINO_C1); % somas as colunas e deixa o número de ocorrência de cada característica
%total = size(TREINO_C1, 1);

%prob_caracteristica_dado_C1 = contagem/total;
% Classe = 'FIM DE SEMANA'

