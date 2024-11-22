function [probsSEM, probsFIMSEM] = classificar(carrinhos, produtos, classes, caracteristicas)
    % Esta função classifica os carrinhos como 'SEMANA' ou 'FIM DE SEMANA'
    % com base nos produtos que contém e as suas respetivas probabilidades

    probsSEM = zeros(1, length(caracteristicas));
    probsFIMSEM = zeros(1, length(caracteristicas));

    s = 0;
    fs = 0;
    for car=1:length(caracteristicas)
        for p=1:length(produtos)
            if ismember(produtos{p}, caracteristicas(car))
                if strcmp(classes(car),'SEMANA')
                    probsSEM(car) = probsSEM(car)+1;
                    s = s+1;
                else
                    probsFIMSEM(car) = probsFIMSEM(car)+1;
                    fs = fs+1;
                end
            end
        end
    end
    probsSEM = probsSEM/s;
    probsFIMSEM = probsFIMSEM/fs;

    %dict_sem = dictionary();
    %dict_fimsem = dictionary();
    %Class = categorical(1, length(carrinhos)-1);

end

