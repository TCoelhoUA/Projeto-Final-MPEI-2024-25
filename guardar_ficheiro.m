function guardar_ficheiro(carrinho)
    file_obj = fopen("lista_compras.txt", "w");
    
    fprintf(file_obj, "Lista de compras:\n");
    for i = 1:length(carrinho)
        if ~isempty(carrinho{i})
            fprintf(file_obj, "%d - %s\n", i, carrinho{i});
        end
    end
    fclose(file_obj);
    
    fprintf("Ficheiro guardado com sucesso como <strong>lista_compras.txt</strong>\n\n");
end

