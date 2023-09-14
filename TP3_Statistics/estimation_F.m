function [rho_F,theta_F, foyer] = estimation_F(rho,theta)
    % Construisons les matrices A et B (du système linéaire de n équations)
    n = length(theta);

    A = [cos(theta), sin(theta)];
    
    X = A \ rho;
    
    rho_F = sqrt(X(1)^2 + X(2)^2);
    theta_F = atan2(X(2),X(1));
    foyer = 1/n * sum(rho - rho_F*cos(theta - theta_F*ones(n,1)));
    
    % on a un pb avec bateau car il y a 2 points de fuite
end

