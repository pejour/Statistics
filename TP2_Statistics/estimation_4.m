function [theta_Dorth_2,rho_Dorth_2] = estimation_4(x_donnees_bruitees,y_donnees_bruitees)
    k = length(x_donnees_bruitees);
    
    % Calcul du barycentre G
    G_x = sum(x_donnees_bruitees)/k;
    G_y = sum(y_donnees_bruitees)/k;
    
    % Calcul de x_centree et y_centree
    x_centree = x_donnees_bruitees - G_x;     
    y_centree = y_donnees_bruitees - G_y;
    
    % calcul de C
    C = [x_centree' y_centree'];
    D = C'*C;
    
    % on récupère les valeurs propres de C'*C et on trouve la vp min
    [~,valeur] = eig(D);
    lambda = min(valeur(1,1),valeur(2,2));
    a = D(1,1);
    b = D(1,2);
    y = (lambda - a)/b;

    y_norm = y/sqrt(1+y^2);
    theta_Dorth_2 = asin(y_norm);
    
    rho_Dorth_2 = G_x*cos(theta_Dorth_2) + G_y*sin(theta_Dorth_2);
end

