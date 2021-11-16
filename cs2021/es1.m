f =@(x) (2*x-sqrt(2)).^2 .* sin(2*x);
g =@(x) (exp(x).*cos(x));

x = linspace(-1,2,100);

fy = f(x);
gy = g(x);

figure(1);
%plot(x,fy,'c-', x,gy,'r-');

plot(x,fy, 'c-');
hold on;
plot(x,gy, 'r-');

axis([-1,2,-3,2]);

xlabel('x');
ylabel('y');
legend('(2x-sqrt(2))^2 * sin(2x)', 'e^xcos(x)');
title('Rappresentazione grafica di funzioni');


