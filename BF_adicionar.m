function BF = BF_adicionar(elemento, BF, k)
    % <strong>USAGE: BF_adicionar</strong>
    % Adiciona um elemento a um Bloom Filter usando k funções de hash
    %
    % <strong>Parâmetros:</strong>
    % <strong>elemento</strong> - Elemento a adicionar
    % <strong>BF</strong> - Bloom Filter
    % <strong>k</strong> - Número de funções de hash
    %
    % <strong>Output:</strong>
    % <strong>BF</strong> - Bloom Filter atualizado

    chave = elemento;
    % Repetir k vezes
    for hf = 1:k
        % 1 - Aplicar a função de hash a elemento
        chave = [chave num2str(hf)];  % Adiciona números às strings, por exemplo: 'Aveiro1', 'Aveiro2', 'Aveiro3'
        index = string2hash(chave);
    
        % 2 - Garantir que o index está no intervalo de 1 a n
        index = mod(index, length(BF)) + 1;

        % 3 - Atualizar o valor para 1 na posição index
        BF(index) = 1;
    end
end

