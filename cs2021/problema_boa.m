% determinare l'altezza x della parte sommersa di una boa
% sferica di raggio R= 0.055m e densita' di massa rho_b = 0.6kg/m^3
% conosciamo il raggio della boa e quindi il volume,
% per calcolare il volume della calotta usiamo la formula assegnata,
% troviamo quindi l'equazione in una incognita,

% Definisco la funzione
R = 0.055; % metri
rhob = 0.6; % kg/m^3

f =@ (x) x.^3 - 3*x.^2*R + 4*R^3*rhob;

% Definisco gli altri parametri
a = 0; b = 2*R;
tol = 1e-8;
kmax = 100;

% Dobbiamo chiedere che la funzione attraversi l'asse

[z,k,res, ERR_B] = bisezione(f,a,b,tol,kmax)

%%
%esercizio boa con Newton
R = 0.055;
rhob = 0.6;
f =@ (x) x.^3 - 3*x.^2*R + 4*R^3*rhob;
df =@ (x) 3*x.^2 - 6*R*x;
tol = 1e-8;
kmax = 100;

figure(1);clf;
fplot(f,[-0.1,0.2]);
grid on;
xlabel('x');
ylabel('y');

x0 = 0.04;

[z,k,res, ERR_N] = newton(f,df,x0,tol,kmax)

hold on;
plot(z,res,'o');

figure(2);clf;
semilogy(ERR_B, 'ko');
hold on;
semilogy(1:length(ERR_N), ERR_N, 'ro');

%%
%esercizio boa con secanti
R = 0.055;
rhob = 0.6;
f =@ (x) x.^3 - 3*x.^2*R + 4*R^3*rhob;
x0 = 0.04;
x1 = 0.1;

tol = 1e-8;
kmax = 100;

figure(1);clf;
fplot(f,[0,2*R])
grid on;
xlabel('x');
ylabel('y');

[z,k,res, ERR_S] = secanti(f,x0,x1,tol,kmax)

hold on;
plot(z,res,'o');

figure(2);clf;
semilogy(ERR_B, 'ko');
hold on;
semilogy(1:length(ERR_N), ERR_N, 'ro');
semilogy(ERR_S, 'bo');