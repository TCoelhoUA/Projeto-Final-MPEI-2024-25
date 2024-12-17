function shingles = minHash_gerar_shingles(produtos, ks)
%<strong>USAGE:minHash_gerar_shingles(produtos, ks)</strong>
%Cria os shingles um conjunto de strings
% <strong>Input:<strong>
%<strong>produtos</strong> - conjunto de strings a criar shingles
%<strong>ks</strong> - tamanho de cada shingle

% <strong>Output</strong>:
% <strong>shingles</strong> - cell array com os shingles de cada produto

    shingles = cell(size(produtos, 1), 1);
    for s = 1:size(produtos, 1)
        n = strlength(produtos{s, 1});

        for c = 1:n-ks+1
            shingles{s}(end+1) = extractBetween(produtos{s, 1}, c, c+ks-1);
        end
    end
end