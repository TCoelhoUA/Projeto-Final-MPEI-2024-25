%% Leitura  e interpretação dos datasets
h = waitbar(0, 'A ler os produtos...', 'Name', 'A processar dados (Por favor espere)');
dados_produtos = readcell("produtos_simplified.csv");  % dataset simplificado (para demonstração)
%dados_produtos = readcell("produtos.csv");  % dataset original (para uso final)

%% Parse dos dados
produtos = string(dados_produtos(2:end, 3));
caracteristicas = unique(produtos);                % Vetor com os tipos distintos de produtos

%% Gerar shingles e assinaturas
waitbar(2/6, h, 'A gerar shingles e assinaturas...');
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

%% Inserção de palavras
waitbar(2/6, h, 'Testando com k=2 shingles...');
palavras = ["brandy"
            "cake bar"
            "chocolate"
            "cocoa drinks"
            "coffee"
            "condensed milk"
            "cream"
            "dessert"
            "dish cleaner"
            "frozen potato products"
            "hamburger meat"
            "kitchen towels"
            "light bulbs"
            "margarine"
            "nut snack"
            "nuts/prunes"
            "pet care"
            "prosecco"
            "ready soups"
            "red/blush wine"
            "soap"
            "soups"
            "syrup"
            "vinegar"
            "whisky"
            ];

mistypes = ["brendi", "brandy1", "browndy";
            "kace bar", "cake bar23", "ceyke bar";
            "cocholate", "chocolate098", "choklate";
            "coca drinks", "cocoa drinks9832", "coaco drink";
            "kofee", "coffee023", "cofe";
            "consed milk", "condensed98milk", "conseded mylk";
            "crem", "cream823", "kream";
            "deserto", "dessert09", "dezerts";
            "diz clean", "202dish cleaner", "dish_cleans";
            "froze patato product", "frozen2potato34products", "frzen potao produkt";
            "amburger meet", "hamburguer2meat", "ambarger meat";
            "kitxen towel", "kitchen23towel34", "kichen touel";
            "laight bulb", "light234bulbs23", "lytht bulb";
            "margarida", "23margarine", "mergarin";
            "nnut sneck", "nut02snack23", "noot snac";
            "nutss/prune", "nuts/34prunes", "nots/ prunes";
            "pete car", "pet45care", "pet ker";
            "proseco", "prosecco93", "proseco";
            "read soup", "ready11soups3", "reads soupas";
            "blue/blush win", "red-blush83wine", "read-blush wines";
            "sopa", "soap66", "saops";
            "soops", "soups0", "suops";
            "sirup", "syrup99", "sirupp";
            "vingar", "1vinegar2", "vinager";
            "whiski", "2whisky33", "whiskis"
            ];

%% k=2 shingles
K2 = zeros(25, 3);
fprintf("\n<strong>TESTE 3: MinHash (k=2 shingles)</strong>\n");
for item = 1:25
    fprintf("<strong>%s</strong>\n", palavras(item));
    for spelling = 1:3
        closest_products = minHash_procurar_prod_mais_prox(char(mistypes(item, spelling)), ks, nhf, R, p, MA_produtos, caracteristicas);
        closest_product = char(closest_products(1));    % aqui usamos 1 pois só nos interessa o produto mais similar
                                                        % e não a sua presença (ou não) no carrinho atual do utilizador
        fprintf("• <strong>%s</strong> corrigido para <strong>%s</strong>\n", mistypes(item, spelling), closest_products(1));
        if strcmp(closest_products(1), palavras(item))
            K2(item, spelling) = 1;
        end
    end
    fprintf("\n");
    waitbar(2/6+2/6*item/25, h, 'Testando com k=2 shingles...');
end

%% Gerar shingles e assinaturas
waitbar(4/6, h, 'Testando com k=3 shingles...');
% Shingles
ks = 3; % 3-shingles
shingles = minHash_gerar_shingles(caracteristicas, ks);

% Assinaturas
nhf = 200;
p = 1234567;
while ~isprime(p)
    p = p+2;
end
R = randi(p, nhf, ks);
MA_produtos = minHash_calcular_assinaturas(shingles, nhf, R, p);

%% k=3 shingles
K3 = zeros(25, 3);
fprintf("\n<strong>TESTE 3: MinHash (k=3 shingles)</strong>\n");
for item = 1:25
    fprintf("<strong>%s</strong>\n", palavras(item));
    for spelling = 1:3
        closest_products = minHash_procurar_prod_mais_prox(char(mistypes(item, spelling)), ks, nhf, R, p, MA_produtos, caracteristicas);
        closest_product = char(closest_products(1));    % aqui usamos 1 pois só nos interessa o produto mais similar
                                                        % e não a sua presença (ou não) no carrinho atual do utilizador
        fprintf("• <strong>%s</strong> corrigido para <strong>%s</strong>\n", mistypes(item, spelling), closest_products(1));
        if strcmp(closest_products(1), palavras(item))
            K3(item, spelling) = 1;
        end
    end
    fprintf("\n");
    waitbar(4/6+2/6*item/25, h, 'Testando com k=3 shingles...');
end

waitbar(1, h, 'Teste terminado!');
delete(h)

MEDIAS = zeros(2, 1);
MEDIAS(1) = sum(sum(K2))/25;
MEDIAS(2) = sum(sum(K3))/25;

%% Plot dos resultados
x = 1:25;

hold on
plot(x, sum(K2'), '-o', 'LineWidth', 1.5);
plot(x, sum(K3'), '-o', 'LineWidth', 1.5);
title("Número de acertos por palavra");
legend("k=2", "k=3", 'Location', 'southeast');
xlabel("palavras(item)");
ylabel("Acertos");
hold off

fprintf("\n<strong>TESTE 3: MinHash (MÉDIAS)</strong>\n");
fprintf("Para k=2 shingles, a média de acertos é: <strong>%f</strong>\n", MEDIAS(1));
fprintf("Para k=3 shingles, a média de acertos é: <strong>%f</strong>\n", MEDIAS(2));