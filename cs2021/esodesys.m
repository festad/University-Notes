% esodesys1
% dati:
tspan = [0,50];
odefun =@ (t,y) [-3*y(1)*y(2)+y(1);...
                 -y(2)+y(1)*y(2)];
y0 = [1;1];

% scegliamo la discretizzazione
h = 1e-2;
Nh = fix((tspan(2) - tspan(1))/h);
%[tn,un] = eulero_esp(odefun,tspan,y0,Nh);
[tn,un] = crank_nicolson_s(odefun,tspan,y0,Nh);

% non esiste una soluzione esplicita, possiamo
% solo capire se quella numerica e' significativa o no

figure(1);clf;
plot(tn,un(:,1),'Linewidth',2);
hold on;
plot(tn,un(:,2),'Linewidth',2);
grid on;
xlabel('t');
ylabel('un');

figure(2);clf;
plot(un(:,1),un(:,2));
hold on;
plot(un(1,1),un(1,2),'r*');
xlabel('y_1');
ylabel('y_2');
grid on;