% climatologia
% latitudini vs variazioni di temperatura

L = [-55; -45; -35; -25; -15; -5; +5; +15; +25; +35; +45; +55; +65];
deltaT = [3.7; 3.7; 3.52; 3.27; 3.2; 3.15; 3.15; 3.25; 3.47; 3.52; 3.65; 3.62; 3.52];
X = vander(L);
a = meg_pivot(X,deltaT);

x1 = linspace(L(1), L(end),100);

y1b = barycentric(L,deltaT,x1);

yp1c = interp1(L,deltaT,x1);

ys = spline(L,deltaT,x1);

% valuto spline e p1c in L=42 e L=59
x2 = [42,59];
y2comp = interp1(L,deltaT,x2);
y2s = spline(L,deltaT,x2);

figure(1); clf;
hold on;

plot(L,deltaT,'.b', 'Markersize',24);
plot(x1,y1b,'-r', 'Linewidth',2);
% genera il fenomeno di Runge perche'
% i punti sono equispaziati

% L'interpolazione globale di Lagrange
% in questo caso non va bene, ha delle
% oscillazioni troppo evidenti

plot(x1,yp1c,'-k', 'Linewidth',2);
plot(x1,ys,'-g', 'Linewidth',2);

plot(x2, y2comp, '*k', 'Markersize', 8);
plot(x2, y2s, '*g', 'Markersize', 8);

grid on;
xlabel('Latitudine');
ylabel('Variazione di temperatura');
legend('Punti di passaggio',...
'Lagrange globale con Barycentric',...
'Lagrange con l''interpolatore composito lineare',...
'Spline cubiche',...
'Approssimazione con composito',...
'Approssimazione con spline');
title('Climatologia, Roma e Oslo')
