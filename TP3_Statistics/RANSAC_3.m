function [C_estime,R_estime] = RANSAC_3(x_donnees_bruitees,y_donnees_bruitees,parametres,n_tests)

% estimation robuste d'un cercle

    ecart = Inf;
    
    % On récupère les parametres => S1, S2, kmax
    S1 = parametres(1);
    S2 = parametres(2);
    kmax = parametres(3);
    
    for i = 1:kmax
        % Tirage aléatoire de 3 points

        ind = randperm(length(x_donnees_bruitees),3);

        x_ = x_donnees_bruitees(ind);
        y_ = y_donnees_bruitees(ind);
       
        [centre_bis,rayon_bis] = cercle_3_points(x_,y_);
        
        distance = abs(sqrt((centre_bis(1) - x_donnees_bruitees).^2 + (centre_bis(2) - y_donnees_bruitees).^2) - rayon_bis);
        
        indice_proche = find(distance <= S1);
        x_proche = x_donnees_bruitees(indice_proche);
        y_proche = y_donnees_bruitees(indice_proche);
        
        nb_points_proche = length(x_proche);

        % On créé un script estimation_3 qui estime le cercle (même fonction que pour l'exercice2 du TP1)
        
        if nb_points_proche/length(x_donnees_bruitees) > S2
            [centre_init, rayon_init, ecart_moyen] = estimation_3(x_proche, y_proche,n_tests);
            
            if ecart_moyen < ecart
                ecart = ecart_moyen;
                C_estime = centre_init;
                R_estime = rayon_init;
            end
        end
    end
    
end


