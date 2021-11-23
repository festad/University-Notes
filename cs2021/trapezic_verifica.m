% verifica della function trapezic
% grado di esattezza
f =@ (x) x.^2;
a = 0;
b = 1;
Imp = trapezic(f,a,b,1)

% verifica dell'ordine
f =@ (x) exp(x);
a = 1;
b = 2;
lex = exp(2)-exp(1);

ERRORE = [];
H = [];

for M = 10:10:200
  Imp = trapezic(f,a,b,M);
  err = abs(lex-Imp);
  H = [H,(b-a)/M];
  ERRORE = [ERRORE, err];
endfor

figure(1); clf;
loglog(H, ERRORE);
hold on;
grid on;
loglog(H,H.^2);
legend('Errore di Trapezi C', 'H^2');
xlabel('H');
ylabel('Errore');