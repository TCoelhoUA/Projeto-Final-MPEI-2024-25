function res = verificarBF(elemento, BF, k)
    % Verifica a pertença de um elemento no Bloom Filter
    %
    % Parâmetros:
    % elemento - elemento a verificar
    % BF - Bloom Filter
    % k - Número de funções de hash
    %
    % Output:
    % res - booleano

    chave = elemento;
    res = 1;
    % Repetir k vezes
    for hf = 1:k
        % 1 - Aplicar a função de hash a elemento
        chave = [chave num2str(hf)];  % Adiciona números às strings, por exemplo: 'Aveiro1', 'Aveiro2', 'Aveiro3'
        index = string2hash(chave);
    
        % 2 - Garantir que o index está no intervalo de 1 a n
        index = mod(index, length(BF)) + 1;

        % 3 - Atualizar o valor para 1 na posição index
        res = res & BF(index);
    end
end

