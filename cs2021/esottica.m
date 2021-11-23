% esottica.m
% temperatura del corpo nero
T = 213;
% funzione integranda
f =@ (x) 2.39e-11./(x.^5.*(exp(1.432./(T*x))-1));
a = 3e-4;
b = 14e-4;
npunti = 51;
% nodi di quadratura,
% decidiamo di usare punti equispaziati
x = linspace(a,b,npunti);
y = f(x);
E = trapz(x,y);
fprintf('Energia emessa = %e\n', E);

% stimo l'errore
 syms xs
 f = 2.39e-11./(xs.^5.*(exp(1.432./(T*xs))-1));
 f2 = diff(f,xs,2);
 F2 = function_handle(f2);
 