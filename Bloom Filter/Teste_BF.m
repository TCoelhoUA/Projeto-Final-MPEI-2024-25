%% Leitura  e interpretação dos datasets
%h = waitbar(0, 'A ler os produtos...', 'Name', 'A processar dados (Por favor espere)');
h = waitbar(1/12, 'A ler os produtos...', 'Name', 'A processar dados (Por favor espere)');
dados_produtos = readcell("produtos_simplified.csv");  % dataset simplificado (para demonstração)
%dados_produtos = readcell("produtos.csv");  % dataset original (para uso final)

%waitbar(1/12, h, 'A ler os carrinhos...');
%carrinhos = readcell("carrinhos_simplified.csv");  % dataset simplificado (para demonstração)
%carrinhos = readcell("carrinhos.csv");  % dataset original (para uso final)

%% Interface -Inicialização do Bloom Filter e input do utilizador
% Inicializar Bloom Filter e agregados
waitbar(10/12, h, 'A inicializar BF...');
BF = BF_inicializar(400);   % 5000 é só um valor aleatório (possivelmente a alterar depois)
k_bloom = 3;  % numero de funcoes de hash

waitbar(1, h, 'Completed!');
delete(h);