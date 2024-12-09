function shingles = gerar_shingles(produtos, ks)
    shingles = cell(size(produtos, 1), 1);
    for s = 1:size(produtos, 1)
        n = strlength(produtos{s, 1});

        for c = 1:n-ks+1
            shingles{s}(end+1) = extractBetween(produtos{s, 1}, c, c+ks-1);
        end
    end
end