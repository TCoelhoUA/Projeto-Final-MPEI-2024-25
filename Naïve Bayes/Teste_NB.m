%% Leitura  e interpretação dos datasets
%h = waitbar(0, 'A ler os produtos...', 'Name', 'A processar dados (Por favor espere)');
h = waitbar(1/12, 'A ler os produtos...', 'Name', 'A processar dados (Por favor espere)');
dados_produtos = readcell("produtos_simplified.csv");  % dataset simplificado (para demonstração)
%dados_produtos = readcell("produtos.csv");  % dataset original (para uso final)

%% Parse dos dados
%waitbar(2/6, h, 'A atribuir classes aos produtos...');
produtos = string(dados_produtos(2:end, 3));
produtos_e_datas = string(dados_produtos(2:end, 2:3));               % Vetor com os vários produtos comprados e as datas (separadamente)
caracteristicas = unique(produtos);                % Vetor com os tipos distintos de produtos

waitbar(8/12, h, 'A atribuir classes aos carrinhos...');
carrinhos = criar_carrinhos(produtos_e_datas);

% Permutação aleatória (90% treino, 10% teste)

permutacao = randperm(length(carrinhos));
idx_treino = round(90/100 * length(carrinhos));
carrinhos_todos = carrinhos;
carrinhos_teste = carrinhos(idx_treino+1:end);
carrinhos = carrinhos(1:idx_treino);

%% Cálculo das probabilidades de cada característica sabendo a classe
% P(característica|classe)
probsSEM = zeros(numel(caracteristicas), 1);
probsFIMSEM = zeros(numel(caracteristicas), 1);
freq = zeros(numel(caracteristicas), 1);

for produto = 1:numel(caracteristicas)
    for car = 1:numel(carrinhos)
        classe = carrinhos{car}{1};
        if any(ismember(carrinhos{car}, caracteristicas(produto)))
            freq(produto) = freq(produto) + 1;
            if strcmp(classe, "SEMANA")
                probsSEM(produto) = probsSEM(produto) + 1;
            else
                probsFIMSEM(produto) = probsFIMSEM(produto) + 1;
            end
        end
    end
end

probsSEM = probsSEM./freq;
probsFIMSEM = probsFIMSEM./freq;
product_prob = [probsSEM probsFIMSEM];
waitbar(1, h, 'Completed!');
delete(h);
%% Classificador Naïve Bayes

RESULTADO = zeros(numel(carrinhos_teste), 1);
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
F1 = (2*precision*recall)/(precision+recall);
fprintf("\n<strong>TESTE 1: Classificador Naïve Bayes</strong>");
fprintf("\nPrecision: %f\nRecall: %d\nAccuracy: %f\nF1: %f\n", precision, recall, accuracy, F1);
%{
acertos = sum(RESULTADO);
erros = numel(carrinhos_teste) - sum(RESULTADO);
fprintf("\n<strong>TESTE 1: Classificador Naïve Bayes</strong>");
fprintf("\nAcertos: %d\nErros: %d\n", acertos, erros);
%}