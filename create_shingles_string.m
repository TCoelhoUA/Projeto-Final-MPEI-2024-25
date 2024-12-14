function shingles = create_shingles_string(string,ks)
%create_shingles cria os shingles de tamanho ks, de uma string 'Title'
%   Title   -   String a ser criado os shingles
%   ks      -   tamanho de cada shingle
    
    Title = string;

    if (ks > length(Title))
        fprintf("ERRO: The shingle size is to big for the title %s\n", Title);
        return
    end
        
    numShingles = length(Title) - ks + 1;
    shingles = cell(1, numShingles);
    
    for i = 1:numShingles
        shingles{i} = Title(i:i + ks - 1);
    end
end