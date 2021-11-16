x = [1000, 20000, 30000, 40000, 50000]';
y = [0.31, 0.95, 2.45, 4.10, 6.46]';

n = 3;
m = length(x);

X = [x.^2, x, ones(m,1)];

[Q,R] = qr(X);

Qtilde = Q(:,1:n);
Rtilde = R(1:n,:);

a = Rtilde\Qtilde'*y

   % 1.2451e-04
   % -6.5707e-01
   
figure(1); clf;
plot(x,y,'b*');
grid on;
hold on;
x1 = linspace(x(1),x(end),100)';
y1 = polyval(a,x1);
yr = polyval(a, x);
plot(x1, y1, 'r', 'Linewidth',2);
title('Tempi di CPU - Minimi quadrati')
xlabel('Dimensione del vettore da ordinare');
ylabel('Tempi di CPU in secondi');

Ls = 55218;
ys = polyval(a, Ls);

plot(Ls, ys, '*g', 'Linewidth', 2);
legend('Punti da approssimare', 'Parabola di regressione', 'Soluzione approssimata');
