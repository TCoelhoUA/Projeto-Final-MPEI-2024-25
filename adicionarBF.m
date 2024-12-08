function BF = adicionarBF(elemento, BF, k)
    % Adicionar 'elemento' a 'BF' usando 'k' funções de hash
    %
    % Parâmetros:
    % elemento - elemento a adicionar
    % BF - Bloom Filter
    % k - Número de funções de hash
    %
    % Output:
    % BF (atualizado)

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

