function [a_DYX_1,b_DYX_1] = estimation_1(x_donnees_bruitees,y_donnees_bruitees,n_tests)
    k = length(x_donnees_bruitees);
    
    % Calcul du barycentre G
    G_x = sum(x_donnees_bruitees)/k;
    G_y = sum(y_donnees_bruitees)/k;
    
    % Calcul de x_centree et y_centree
    x_centree = x_donnees_bruitees - G_x;
    y_centree = y_donnees_bruitees - G_y;
    
    % Création du vecteur phi_test
    phi = -pi/2 + pi*rand(n_tests,1);
    
    
    % Calcul de la matrice des résidus
    
    res = (y_centree - tan(phi(:,1)).*x_centree).^2;
    
    % Récupérer l'indice du min
    
    [~,indice]= min(sum(res,2));
    
    % Calculer a* et b*
    
    a_DYX_1 = tan(phi(indice));
    
    b_DYX_1 = G_y - a_DYX_1*G_x;
end

