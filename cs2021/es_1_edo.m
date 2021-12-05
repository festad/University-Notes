% es 1 equazioni differenziali
odefun=@(t,y) t-y;
tspan = [-1,3];
T = tspan(2); t0 = tspan(1);
y0 = 1;
Nh = 50;
[tn,un] = eulero_esp(odefun,tspan,y0,Nh);

figure(1); clf;
plot(tn,un,'.--');
xlabel('t');
ylabel('y(t)');
hold on;
% soluzione esatta
yex =@ (t) t-1+3*exp(-t-1);
t1 = linspace(tspan(1),tspan(2),500);
plot(t1,yex(t1));
