function words = loadWords(frases)
    % Retorna um array com todas as palavras de "doc" (sem repetir)
    % doc - cell array

    words = {};
    for f = 1:numel(frases)
        frase = frases{f};
        palavras = frase.split();
        for p = 1:numel(palavras)
            if ~ismember(palavras(p), words)
                words{1, end+1} = palavras{p};
            end
        end
    end
end