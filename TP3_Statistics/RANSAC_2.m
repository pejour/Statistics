function [rho_F_1,theta_F_1] = RANSAC_2(rho,theta,parametres)
    ecart = Inf;
    
    % On récupère les parametres => S1, S2, kmax
    S1 = parametres(1);
    S2 = parametres(2);
    kmax = parametres(3);
    
    for i = 1:kmax
        % Tirage aléatoire de 2 droites
        n = length(rho);
        ind = randperm(n,2);

        rho_ = rho(ind);
        theta_ = theta(ind);

        [rho_bis, theta_bis] = estimation_F(rho_, theta_);

        distance = abs(rho - rho_bis*cos(theta-theta_bis));
        proche = find(distance <= S1);


        nb_droite_proche = length(proche);
        nb_droite = length(rho);

        if nb_droite_proche/nb_droite > S2
            [rho_init, theta_init, ecart_moyen] = estimation_F(rho(proche), theta(proche));
            if ecart_moyen < ecart
                ecart = ecart_moyen;
                rho_F_1 = rho_init;
                theta_F_1 = theta_init;
            end
        end
    end
    
end

