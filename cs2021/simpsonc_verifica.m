% verifica della function simpsonc
% grado di esattezza
f =@ (x) 2*x.^3+x.^2-3*x-2;
a = -2;
b = 2;
Imp = simpsonc(f,a,b,1)

% verifica dell'ordine
f =@ (x) exp(x);
a = 1;
b = 2;
lex = exp(2)-exp(1);

ERRORE = [];
H = [];

for M = 10:10:200
  Imp = simpsonc(f,a,b,M);
  err = abs(lex-Imp);
  H = [H,(b-a)/M];
  ERRORE = [ERRORE, err];
endfor

figure(1); clf;
loglog(H, ERRORE);
hold on;
grid on;
loglog(H,H.^4);
legend('Errore di SimpsonC', 'H^4');
xlabel('H');
ylabel('Errore');