% traiettoria del robot
% posizione iniziale (2, 7.2)
% transito in tabella

% interpolazione globale
% interpolazione composita
% [spline]

x = [2.00;
     4.25;
     5.25;
     7.81;
     9.20;
     10.60];
y = [7.2;
     7.1;
     6.0; 
     5.0; 
     3.5; 
     5.0];
%

% interpolazione globale di lagrange
% con matrice di Vandermonde

X = vander(x);

% risolvo il sistema Xa = y
% meg con LU
% a = vettore dei coefficienti
a = meg_pivot(X,y);

% definisco un nuovo vettore di punti
% ben piu' fitti dei nodi di interpolazione
% per valutare il polinomio
x1 = linspace(x(1),x(end),100);

% valuto il polinomio di coefficienti a1
% nei nodi x1, -> pn(x) in x1, con n=5
y1 = polyval(a,x1);

% calcolo il polinomio globale di Lagrange con
% formula baricentrica
y1b = barycentric(x,y,x1);

% interpolatore composito lineare
% interp1, costruisce una retta
% per gli estremi di ogni intervallo
yp1c = interp1(x,y,x1);

ys = spline(x,y,x1);

figure(1); clf;
% disegno i dati del mio problema 
plot(x,y,'.b', 'Markersize',24);
hold on;
plot(x1,y1,'-b', 'Linewidth',4);
% barycentric
plot(x1,y1b,'-r', 'Linewidth',2);
% lagrange composito lineare
plot(x1,yp1c,'-g', 'Linewidth',2);
% spline
plot(x1,ys,'-k', 'Linewidth',2);

grid on;
xlabel('Ascisse');
ylabel('Ordinate');
legend('Punti di passaggio', 'Lagrange globale con Vandermonde',...
'Lagrange globale con Barycentric',...
'Lagrange con l''interpolatore composito lineare',...
'Spline cubiche');
