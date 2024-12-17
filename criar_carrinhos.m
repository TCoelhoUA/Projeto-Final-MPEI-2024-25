function [carrinhos, h] = criar_carrinhos(produtos_e_datas, h)
    % <strong>USAGE: minHash_calcular_assinaturas(shingles, nhf, R, p)</strong>
    % Calcula a matriz assinatura
    %
    % <strong>Input:</strong>
    % <strong>produtos_e_datas</strong> - Matriz com a data de compra e o nome de cada produto
    % <strong>h</strong> - waitbar atual
    %
    % <strong>Output:</strong>
    % <strong>carrinhos</strong> - carrinhos
    % <strong>h</strong> - waitbar atualizada

    num_datas = unique(produtos_e_datas(:, 1)); % Número de datas diferentes (1 data equivale a 1 carrinho)
    num_carrinhos = numel(num_datas);
    
    carrinhos = cell(num_carrinhos, 1);
    months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    for carrinho_idx = 1:num_carrinhos
        current_date = num_datas{carrinho_idx};
        
        matching_rows = strcmp(produtos_e_datas(:, 1), current_date);
        items = produtos_e_datas(matching_rows, 2);
        
        unique_items = unique(items);

        data = string(strsplit(current_date, "-"));
        for m = 1:12
            if strcmp(months(m), data(2))
                mes = m;
                break
            end
        end
        
        t = datetime(double(data(3)), mes, double(data(1)),'Format','eee dd-MMM-yyyy');
        if isweekend(t)
            classe = "FIM DE SEMANA";
        else
            classe = "SEMANA";
        end

        carrinhos{carrinho_idx} = [classe, current_date, unique_items'];
        waitbar(1/6+1/6*carrinho_idx/num_carrinhos, h, 'A atribuir classes aos carrinhos...')
    end
end