function [theta_Dorth_1,rho_Dorth_1] = estimation_3(x_donnees_bruitees,y_donnees_bruitees,n_tests)
    k = length(x_donnees_bruitees);
    
    % Calcul du barycentre G
    G_x = sum(x_donnees_bruitees)/k;
    G_y = sum(y_donnees_bruitees)/k;
    
    % Calcul de x_centree et y_centree
    x_centree = x_donnees_bruitees - G_x;     
    y_centree = y_donnees_bruitees - G_y;
    
    
    % on tire aléatoirement des angles theta entre 0 et pi
    theta = pi*rand(n_tests,1);
    
    
    % Calcul de la matrice des résidus
    
    res = (sin(theta(:,1)).*y_centree + cos(theta(:,1)).*x_centree).^2;
    
    % Récupérer l'indice du min
    
    [~,indice]= min(sum(res,2));

    theta_Dorth_1 = theta(indice);
    rho_Dorth_1 = G_x*cos(theta_Dorth_1) + G_y*sin(theta_Dorth_1);
end

