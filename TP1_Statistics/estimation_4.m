function [C_estime,R_estime] = estimation_4(x_donnees_bruitees,y_donnees_bruitees,n_tests)
    
    % calcul du barycentre G des (xi,yi)
    k = length(x_donnees_bruitees);
    Gx = sum(x_donnees_bruitees)/k;
    Gy = sum(y_donnees_bruitees)/k;
    
    
    % calcul du rayon moyen R_ 
    dx_Gx = x_donnees_bruitees - Gx;
    dy_Gy = y_donnees_bruitees - Gy;
    
    Rxy = sqrt(dx_Gx.^2 + dy_Gy.^2);
    R_ = sum(Rxy)/k;
    
    % Génération aléatoire des centre C et des rayons R
    Cx = Gx + randn (n_tests,1);
    Cy = Gy + randn (n_tests,1);
    
    R = R_ + rand(n_tests,1);
    
    % Calcul de l'estimation du centre
    
    x_c = kron(ones(k,1),transpose(Cx));   % kron -> symbole de Kronecker
    y_c = kron(ones(k,1),transpose(Cy));
    
    x_db = repmat(transpose(x_donnees_bruitees),1,n_tests);
    y_db = repmat(transpose(y_donnees_bruitees),1,n_tests);
    
    
    % Calcul des distances de chaque point à un sommet i correspondant
    
    dxy_Cxy = sqrt((x_c - x_db).^2 + (y_c - y_db).^2);
    ecart_Cxy = (dxy_Cxy - R_).^2;
    
    res = sum(ecart_Cxy);
    [~,ind_c] = min(res);
    
    
    % estimation du rayon R_estime
    
    dR = sum((R - R_*ones(n_tests,1)).^2,2);
    [~,ind_R] = min(dR);
    
    C_estime = [Cx(ind_c), Cy(ind_c)];
    R_estime = R(ind_R);
end

