%% Leitura  e interpretação dos datasets
h = waitbar(0, 'A ler os produtos...', 'Name', 'A processar dados (Por favor espere)');
%dados_produtos = readcell("produtos_simplified.csv");  % dataset simplificado (para demonstração)
dados_produtos = readcell("produtos.csv");  % dataset original (para uso final)

PRECISION = zeros(10, 1);
RECALL = zeros(10, 1);
ACCURACY = zeros(10, 1);
F1 = zeros(10, 1);
for i=1:10
    waitbar(1/12+11/12*(i-1)/10, h, 'A fazer as iterações...');
    %% Parse dos dados
    produtos = string(dados_produtos(2:end, 3));
    produtos_e_datas = string(dados_produtos(2:end, 2:3));               % Vetor com os vários produtos comprados e as datas (separadamente)
    caracteristicas = unique(produtos);                % Vetor com os tipos distintos de produtos
    
    carrinhos = criar_carrinhos(produtos_e_datas);
    
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
    end
    prob_sem = prob_sem/numel(carrinhos);
    prob_fimsem = prob_fimsem/numel(carrinhos);

    %% Cálculo das probabilidades de cada característica sabendo a classe
    % P(característica|classe)
    [product_prob, freq] = bayes_calculo_prob_caract(carrinhos, caracteristicas);

    %% Classificador Naïve Bayes
    tp = 0;
    fp = 0;
    fn = 0;
    tn = 0;
    
    %{
                            Classe Original
                                   ____________________________
                  ________________| 'SEMANA' | 'FIM DE SEMANA' |
         Classe  |       'SEMANA' |‾‾‾‾‾‾‾‾‾‾|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|
    Naïve Bayes  |'FIM DE SEMANA' |‾‾‾‾‾‾‾‾‾‾|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾|
                  ‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
    %}
    for car = 1:numel(carrinhos_teste)
        classe_real = carrinhos_teste{car}{1};
    
        classe_carrinho = bayes_classificar_carrinho(carrinhos_teste{car}(3:end), caracteristicas, product_prob, prob_sem, prob_fimsem);
        if strcmp(classe_real, "SEMANA")
            if strcmp(classe_real, "SEMANA")
                tp = tp+1;
            else
                fn = fn+1;
            end
        else
            if strcmp(classe_real, "FIM DE SEMANA")
                fp = fp+1;
            else
                tn = tn+1;
            end
        end
    end
    precision = tp/(tp+fp);
    recall = tp/(tp+fn);
    accuracy = (tp+tn)/(tp+fp+tn+fn);
    f1 = (2*precision*recall)/(precision+recall);
    fprintf("\n<strong>TESTE 1: Classificador Naïve Bayes</strong>");
    fprintf("\nPrecision: %f\nRecall: %d\nAccuracy: %f\nF1: %f\n", precision, recall, accuracy, f1);
    
    PRECISION(i) = precision;
    RECALL(i) = recall;
    ACCURACY(i) = accuracy;
    F1(i) = f1;
    waitbar(1/12+11/12*i/10, h, 'A fazer as iterações...');
end
delete(h)
%% Média dos resultados
MEDIAS = zeros(4, 1);
MEDIAS(1) = sum(PRECISION)/10;
MEDIAS(2) = sum(RECALL)/10;
MEDIAS(3) = sum(ACCURACY)/10;
MEDIAS(4) = sum(F1)/10;

fprintf("\n<strong>TESTE 1: Classificador Naïve Bayes (MÉDIAS)</strong>");
fprintf("\nPrecision: %f\nRecall: %d\nAccuracy: %f\nF1: %f\n", MEDIAS(1), MEDIAS(2), MEDIAS(3), MEDIAS(4));

%% Plot dos resultados
x = 1:10;

figure;

subplot(2,2,1);
hold on
plot(x, PRECISION, '-o', 'LineWidth', 1.5);
plot(x, MEDIAS(1)+zeros(10,1), 'LineWidth', 1.5);
hold off
title("Precisão");
legend("Precisão", "Média da Precisão");
grid on;

subplot(2,2,2);
hold on
plot(x, RECALL, '-o', 'LineWidth', 1.5);
plot(x, MEDIAS(2)+zeros(10,1), 'LineWidth', 1.5);
hold off
title("Recall");
legend("Recall", "Média do Recall");
grid on;

subplot(2,2,3);
hold on
plot(x, ACCURACY, '-o', 'LineWidth', 1.5);
plot(x, MEDIAS(3)+zeros(10,1), 'LineWidth', 1.5);
hold off
title("Accuracy");
legend("Accuracy", "Média da Accuracy");
grid on;

subplot(2,2,4);
hold on
plot(x, F1, '-o', 'LineWidth', 1.5);
plot(x, MEDIAS(4)+zeros(10,1), 'LineWidth', 1.5);
hold off
title("F1");
legend("F1", "Média de F1");
grid on;