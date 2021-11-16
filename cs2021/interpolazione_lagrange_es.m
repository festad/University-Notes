% interpolazione globale di Lagrange

% funzione da interpolare
f=@(x) (x+2)/7.*cos(x);
% intervallo
xa = 0;
xb = 6;
% nodi per il disegno e il calcolo dell'errore
x1 = linspace(xa, xb, 200)';

% valuto f nei nodi
yf = f(x1);

% costruisco il polinomio p_n
n = 4;

errore = [];

for n=1:10
% costuisco i nodi di interpolazione (#n+1)
x = linspace(xa, xb, n+1)';

% valuto f nei nodi di interpolazione
y = f(x);

% costuisco il polinomio con la formula baricentrica
y1 = barycentric(x,y,x1);


figure(1); clf;
plot(x1,yf,'Linewidth',2);
hold on;
plot(x1,y1,'Linewidth',2);
plot(x,y,'ko','Markerfacecolor','k', 'Markersize',8);
legend('f(x)', ['p_{',num2str(n),'}(x)'], 'Nodi di interpolazione',...
'Location','Northwest');

% calcolo l'errore
err = norm(yf - y1, inf);
% err = max(abs(yf - y1));
errore = [errore;err];
fprintf('\nn = %d, errore = %e\n\n', n, err);
pause(0.1);

endfor

% in questo caso la funzione e' buona,
% quindi anche se i nodi sono equispaziati
% l'interpolazione funziona bene


% disegno gli errori al variare di n
figure(2);clf;
semilogy(1:10, errore, '-o', 'Markerfacecolor','k','Linewidth',2);
grid on;
xlabel('Grado polinomiale n');
ylabel('Errore di interpolazione');