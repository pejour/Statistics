function [centre_init, rayon_init, ecart_moyen] = estimation_3(x_proche,y_proche,n_tests)
    
    % calcul du barycentre G des (xi,yi)
    k = length(x_proche);
    Gx = sum(x_proche)/k;
    Gy = sum(y_proche)/k;
    
    
    % calcul du rayon moyen R_ 
    dx_Gx = x_proche - Gx;
    dy_Gy = y_proche - Gy;
    
    Rxy = sqrt(dx_Gx.^2 + dy_Gy.^2);
    R_ = sum(Rxy)/k;
    
    % Génération aléatoire des centre C et des rayons R
    Cx = Gx -0.5*R_ + R_*rand(n_tests,1);
    Cy = Gy -0.5*R_ + R_*rand(n_tests,1);
    
    R = 0.5*R_ + R_*rand(n_tests,1);
    
    % Calcul de l'estimation du centre
    
    x_c = kron(ones(k,1),transpose(Cx));   % kron -> symbole de Kronecker
    y_c = kron(ones(k,1),transpose(Cy));
    
    x_db = repmat(transpose(x_proche),1,n_tests);
    y_db = repmat(transpose(y_proche),1,n_tests);
    
    
    % Calcul des distances de chaque point à un sommet i correspondant
    
    dxy_Cxy = sqrt((x_c - x_db).^2 + (y_c - y_db).^2);
    ecart_Cxy = (dxy_Cxy - R_).^2;
    
    res = sum(ecart_Cxy);
    [~,ind_c] = min(res);
    
    
    % estimation du rayon R_estime
    
    dR = sum((R - R_*ones(n_tests,1)).^2,2);
    [~,ind_R] = min(dR);
    
    centre_init = [Cx(ind_c), Cy(ind_c)];
    rayon_init = R(ind_R);
    ecart_moyen = mean(abs(rayon_init - sqrt((centre_init(1) - x_proche).^2 + (centre_init(2) - y_proche).^2)));
end

