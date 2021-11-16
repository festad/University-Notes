f =@ (x) 1./(1+x.^2);
xa = -5;
xb = +5;

x1 = linspace(xa,xb,200)';
yf = f(x1);

errore = [];

nodi = menu('Choose between interpolating nodes:',...
 'equispaced', 'Gauss-Chebyshev');

for n=2:14
  
  if nodi == 1
    % costruisco i nodi di interpolazione
  elseif nodi == 2
    % gauss chebyshev
    xs = -cos(pi*(0:n)'/n);
    x = (xb-xa)/2*xs + (xb+xa)/2;
  endif
  
  
  %x = linspace(xa, xb, n+1)';
  
  y = f(x);
  y1 = barycentric(x,y,x1);
  
  figure(1); clf;
  plot(x1,yf,'Linewidth',2);
  hold on;
  plot(x1,y1,'Linewidth',2);
  plot(x,y,'ko','Markerfacecolor','k', 'Markersize',4);
  legend('f(x)', ['p_{',num2str(n),'}(x)'], 'Nodi di interpolazione',...
  'Location','Northwest');
  % calcolo l'errore
  err = norm(yf - y1, inf);
  % err = max(abs(yf - y1));
  errore = [errore;err];
  fprintf('\nn = %d, errore = %e\n\n', n, err);
  pause(0.1);
end

figure(2);clf;
semilogy(2:14, errore, '-o', 'Markerfacecolor','k','Linewidth',2);
grid on;
xlabel('Grado polinomiale n');
ylabel('Errore di interpolazione');

% la soluzione al fenomeno di Runge e' usare i nodi di 