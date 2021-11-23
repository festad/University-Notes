%asimpson_test
a = 0;
b = 2;
tol = 1e-5;
hmin = 1e-6; % un pochino piu' piccolo della tolleranza
% l'errore dovrebbe andare come H^4

f =@ (x) 1./((x-0.3).^2+0.01) + ...
         1./((x-0.9).^2+0.04) - 6;
%

f =@ (x) 1./(x.^3-2*x-5);

[isa,NODI] = asimpson(f,a,b,tol,hmin);

fprintf('Valore calcolato = %e\n\n', isa);
figure(1); clf;
fplot(f,[a,b]);
hold on;
plot(NODI,zeros(size(NODI)), 'r+');
xlabel('x');
ylabel('f(x)');
legend('Funzione originale', 'Nodi');
title('Algoritmo adattivo di Simpson');
grid on;
