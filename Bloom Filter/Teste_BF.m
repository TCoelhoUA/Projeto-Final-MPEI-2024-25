%% Leitura  e interpretação dos datasets
h = waitbar(0, 'A ler os produtos...', 'Name', 'A processar dados (Por favor espere)');
%dados_produtos = readcell("produtos_simplified.csv");  % dataset simplificado (para demonstração)
dados_produtos = readcell("produtos.csv");  % dataset original (para uso final)
waitbar(1/12, h, 'A ler os produtos...');

%% Parse dos dados
produtos = string(dados_produtos(2:end, 3));
caracteristicas = unique(produtos);                % Vetor com os tipos distintos de produtos

TP = zeros(1000, 1);
FP = zeros(1000, 1);
FN = zeros(1000, 1);
TN = zeros(1000, 1);
for i = 1:1000
    tp = 0;
    fp = 0;
    fn = 0;
    tn = 0;

    waitbar(1/12+11/12*(i-1)/1000, h, 'A ler os produtos...');
    %% Interface -Inicialização do Bloom Filter e input do utilizador
    % Inicializar Bloom Filter e agregados
    BF = BF_inicializar(400);
    k_bloom = 3;  % numero de funcoes de hash

    itens_idx = randperm(length(caracteristicas), 25);

    % Adicionamos 20 produtos
    for item = 1:20
        BF = BF_adicionar(char(caracteristicas(itens_idx(item))), BF, k_bloom);
    end

    % Testar com 20 itens adicionados
    for item = 1:20
        if BF_verificar(char(caracteristicas(itens_idx(item))), BF, k_bloom) % Muito provável existir
            tp = tp +1;
        else    % Não existe
            fn = fn +1;
        end
    end

    % Testar com 5 itens não adicionados
    for item = 21:25
        if BF_verificar(char(caracteristicas(itens_idx(item))), BF, k_bloom) % Muito provável existir
            fp = fp +1;
        else    % Não existe
            tn = tn +1;
        end
    end

    fprintf("\n<strong>TESTE 2: Bloom Filter</strong>");
    fprintf("\nTrue Positive: %d\nFalse Positive: %d\nFalse Negative: %d (Tem que ser 0)\nTrue Negative: %d (Deve ser 5)\n", tp, fp, fn, tn);

    TP(i) = tp;
    FP(i) = fp;
    FN(i) = fn;
    TN(i) = tn;
    waitbar(1/12+11/12*i/1000, h, 'A ler os produtos...');
end
delete(h)

%% Média dos resultados
MEDIAS = zeros(4, 1);
MEDIAS(1) = sum(TP)/1000;
MEDIAS(2) = sum(FP)/1000;
MEDIAS(3) = sum(FN)/1000;
MEDIAS(4) = sum(TN)/1000;

fprintf("\n<strong>TESTE 2: Bloom Filter (MÉDIAS)</strong>");
fprintf("\nTrue Positives: %f\nFalse Positives: %d\nFalse Negatives: %f (Tem que ser 0)\nTrue Negatives: %f (Deve ser 5)\n", MEDIAS(1), MEDIAS(2), MEDIAS(3), MEDIAS(4));

%% Plot dos resultados
x = 1:1000;


figure;

subplot(2,2,1);
hold on
plot(x, TP, '-o', 'LineWidth', 1.5);
plot(x, MEDIAS(1)+zeros(1000,1), 'LineWidth', 1.5);
hold off
title("True Positives");
legend("tp", "Média da tp");
grid on;

subplot(2,2,2);
hold on
plot(x, FP, '-o', 'LineWidth', 1.5);
plot(x, MEDIAS(2)+zeros(1000,1), 'LineWidth', 1.5);
hold off
title("False Positives");
legend("fp", "Média do fp");
grid on;

subplot(2,2,3);
hold on
plot(x, FN, '-o', 'LineWidth', 1.5);
plot(x, MEDIAS(3)+zeros(1000,1), 'LineWidth', 1.5);
hold off
title("False Negatives");
legend("fn", "Média da fn");
grid on;

subplot(2,2,4);
hold on
plot(x, TN, '-o', 'LineWidth', 1.5);
plot(x, MEDIAS(4)+zeros(1000,1), 'LineWidth', 1.5);
hold off
title("True Negatives");
legend("tn", "Média de tn");
grid on;