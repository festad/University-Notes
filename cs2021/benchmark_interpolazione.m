f =@(x) 1./(1+x.^2);
xa = -5;
xb = +5;

x1 = linspace(xa,xb,200)';

yf = f(x1);

v_err_bar = [];
v_err_vander = [];

for n=4:64
  
  % gauss chebyshev
  xs = -cos(pi*(0:n)'/n);
  x = (xb-xa)/2*xs + (xb+xa)/2;
  y = f(x);
  
  % barycentric
  y1b = barycentric(x,y,x1);
  
  % vandermonde
  X = vander(x);
  a = meg_pivot(X,y);
  y1v = polyval(a,x1);
  
  figure(1);clf;
  plot(x1,yf,'Linewidth',2);
  hold on;
  plot(x,y,'Markerfacecolor','k');
  plot(x1,y1v,'Linewidth',2);
  plot(x1,y1b, 'Linewidth',2);
  legend('Vandermonde', 'Barycentric');
  xlabel(['Grado ', num2str(n)])
  
  err_bar = norm(yf - y1b, inf);
  v_err_bar = [v_err_bar,err_bar];
  err_vander = norm(yf - y1v, inf);
  v_err_vander = [v_err_vander,err_vander];
  
  pause(0.01);
  
end

figure(2);clf;
semilogy(4:64, v_err_vander, '-o', 'Markerfacecolor','k','Linewidth',2);
hold on;
grid on;
semilogy(4:64, v_err_bar, '-o', 'Markerfacecolor','k','Linewidth',2);
xlabel('Grado polinomiale n');
ylabel('Errore di interpolazione');
legend('Vandermonde', 'Barycentric');

% la matrice di Vandermonde e' malcondizionata