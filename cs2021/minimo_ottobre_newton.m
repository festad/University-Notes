h   =@ (x) (x-5).^2 - 3*sin(x-5);
dh  =@ (x) 2*(x-5) - 3*cos(x-5);
d2h =@ (x) 3*sin(x-5) + 2;

x = linspace(-10,10,1000);
y = h(x);
dy = dh(x);
d2y = d2h(x);

figure(1);clf;
plot(x,y,'b-', x,dy,'r-', x,d2y,'g-');
grid on;
title('h(x), h''(x) and h''''(x)');
hold on;

%% x0 = 0

x0 = 0;
tol = 1e-8;
kmax = 100;
[z1,res1,k1,ERR1] = newton(dh, d2h, x0, tol, kmax)

figure(2);clf;
plot(x,y,'b-', x,dy,'r-', z1,res1,'rx');
legend('h(x)', 'h''(x)', 'x_0 = 0');
title('x_0 = 0');

%% x0 = 1

x0 = 1;
tol = 1e-8;
kmax = 100;
[z2,res2,k2,ERR2] = newton(dh, d2h, x0, tol, kmax)

figure(3);clf;
plot(x,y,'b-', x,dy,'r-', z2,res2,'bx');
legend('h(x)', 'h''(x)', 'x_0 = 1');
title('x_0 = 1');

figure(1);
plot(z1,res1,'rx', z2,res2,'bx');
legend('h(x)', 'h''(x)', 'h''''(x)','x_0 = 0', 'x_0 = 1');

figure(4);clf;
semilogy(ERR1);
hold on;
semilogy(ERR2);
legend('Errors from x_0 = 0', 'Errors from x_0 = 1');