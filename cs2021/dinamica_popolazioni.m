h =@ (x) (x-5).^2 - 3*sin(x-5);
dh =@ (x) 2*(x-5) - 3*cos(x-5);

x = linspace(0,10,100);
y = h(x);
dy = dh(x);

figure(1);clf;
plot(x,y,'b-', x,dy,'r-');
grid on;
title('h(x) and h''(x)');
hold on;
