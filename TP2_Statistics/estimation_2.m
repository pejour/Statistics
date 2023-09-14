function [a_DYX_2,b_DYX_2] = estimation_2(x_donnees_bruitees,y_donnees_bruitees)
    % on cherche une solution approchée du système linéaire AX = B
    k = length(x_donnees_bruitees);
    A = ones(k,2);
    A(:,1) = x_donnees_bruitees;
    
    res = (A'*A)\A'*(y_donnees_bruitees)';
    
    a_DYX_2 = res(1);
    b_DYX_2 = res(2);
    
end

