clear;
close all;

taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Fenetre d'affichage :
figure('Name','Points situes au voisinage d''un cercle', ...
       'Position',[0.4*L,0.05*H,0.6*L,0.7*H]);
axis equal;
hold on;
set(gca,'FontSize',20);
hx = xlabel('$x$','FontSize',30);
set(hx,'Interpreter','Latex');
hy = ylabel('$y$','FontSize',30);
set(hy,'Interpreter','Latex');

% Bornes d'affichage des donnees centrees en (0,0) :
taille = 20;
bornes = [-taille taille -taille taille];

% Creation du cercle et des donnees bruitees :
n = 50;
sigma = 0.5;
[x_cercle,y_cercle,x_donnees_bruitees,y_donnees_bruitees,theta_donnees_bruitees] ...
		= creation_cercle_et_donnees_bruitees(taille,n,sigma);

% on génère aléatoirement theta1 et theta2

theta1 = 2*pi*rand;
theta2 = 2*pi*rand;
k = length(x_donnees_bruitees);
theta_i = asin(y_donnees_bruitees);

% on ne sélectionne que les points Pi qui nous intéressent (selon les cas)

if theta1 <= theta2
    for i = 1:k
        if 0 < theta_i(i) < theta1 && 2*pi > theta_i(i) > theta2
            x_donnees_bruitees(x_donnees_bruitees == cos(theta_i(i))) = [];   % on enlève les valeurs pour theta i n'appartenant pas à l'intervalle
            y_donnees_bruitees(y_donnees_bruitees == sin(theta_i(i))) = [];
        end
    end
else
    for i = 1:k
        if theta_i(i) > theta1 && theta_i(i) < theta2
            x_donnees_bruitees(x_donnees_bruitees == cos(theta_i(i))) = [];   % on enlève les valeurs pour theta i n'appartenant pas à l'intervalle
            y_donnees_bruitees(y_donnees_bruitees == sin(theta_i(i))) = [];
        end
    end
end

% Affichage du cercle :
plot(x_cercle([1:end 1]),y_cercle([1:end 1]),'r','LineWidth',3);

% Affichage des donnees bruitees :
plot(x_donnees_bruitees,y_donnees_bruitees,'k+','MarkerSize',10,'LineWidth',2);
axis(bornes);
lg = legend(' Cercle', ...
		' Donnees bruitees', ...
		'Location','Best');
grid on;
