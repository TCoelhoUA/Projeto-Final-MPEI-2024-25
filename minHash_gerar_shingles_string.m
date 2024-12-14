function shingles = minHash_gerar_shingles_string(string,ks)
%minHash_gerar_shingles_string cria os shingles de uma unica string
%   string  -   string a criar shingles
%   ks      -   tamanho de cada shingle
    
    if (ks > length(string))
        fprintf("ERRO: O tamanho dos shingles é demasiado grande para dividir a string '%s'\n", string);
        return
    end
        
    numShingles = length(string) - ks + 1;
    shingles = cell(1, numShingles);
    
    for i = 1:numShingles
        shingles{i} = string(i:i + ks - 1);
    end
end