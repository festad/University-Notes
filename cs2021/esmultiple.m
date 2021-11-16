f =@ (x) sin(x-1) - 0.5*sin(2*(x-1));

figure(1); clf;
fplot(f,[-3,3]);
grid on;
hold on;

%% 
% richiamo Newton

df =@ (x) cos(x-1) - cos(2*(x-1));
% calcolo la radice a sinistra
x0 = -2;
x1 = -2.2;
tol = 1e-8;
kmax = 100;
[z,res,k,ERR] = secanti(f,x0,x1,tol,kmax)

plot(z,res,'o');

% calcolo la radice a destra
x0 = 1.2;
x1 = 1.3;
tol = 1e-8;
kmax = 100;
[z2,res2,k2,ERR2] = secanti(f,x0,x1,tol,kmax)

plot(z2,res2,'o');

% rappresento ERR e ERR2 su un grafico

figure(2);clf;
semilogy(0:length(ERR)-1,ERR, 'ro');
%legend('-dynamiclegend');
hold on;
semilogy(0:length(ERR2)-1,ERR2,'bo');
grid on;