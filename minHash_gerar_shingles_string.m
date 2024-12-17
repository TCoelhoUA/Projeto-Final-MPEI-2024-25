function shingles = minHash_gerar_shingles_string(string,ks)
%<strong>USAGE:minHash_gerar_shingles_string(string,ks)</strong>
%Cria os shingles de uma unica string
% <strong>Input:</strong>
% <strong>string<strong> - string a criar shingles
% <strong>ks<strong> - tamanho de cada shingle
% 
% <strong>Output:</strong>
% <strong>shingles</strong> - shingles gerados
    
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