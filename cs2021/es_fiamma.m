% es fiamma
odefun =@ (t,y) y^2 - y^3;
delta = 0.002;
y0 = delta;
tspan = [0,2/delta];

tol = 1.e-3;
hmin = 1.e-4;
[tn,un] = eulero_esp_adattivo(odefun,tspan,y0,tol,hmin);
figure(1);clf;
plot(tn,un,'.--');
grid on;
xlabel('t');
ylabel('y');
