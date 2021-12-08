% es 1 equazioni differenziali
odefun=@(t,y) t-y;
tspan = [-1,3];
T = tspan(2); t0 = tspan(1);
y0 = 1;
Nh = 100;
[tn,un] = heun(odefun,tspan,y0,Nh);

figure(1); clf;
plot(tn,un,'.--');
xlabel('t');
ylabel('y(t)');
hold on;
% soluzione esatta
yex =@ (t) t-1+3*exp(-t-1);
t1 = linspace(tspan(1),tspan(2),500);
plot(t1,yex(t1));

% calcolo l'errore
err = max(abs(un-yex(tn)));
h = (tspan(2)-tspan(1))/Nh;
fprintf('h = %e, errore = %e\n\n', h,err);

ERR = [];
H = [];
for nh = [10,20,40,100]
  [tn,un] = heun(odefun,tspan,y0,nh, 1e-5,200);
  plot(tn,un,'--');
  xlabel('t');
  ylabel('y(t)');
  ERR = [ERR,max(abs(un-yex(tn)))];
  H = [H,(tspan(2)-tspan(1))/nh];
end
legend('Eulero esplicito','Soluzione esatta',...
'Nh = 10', 'Nh = 100', 'Nh = 500', 'Nh = 1000');

figure(2);clf;
loglog(H,ERR, H, H.^2);
xlabel('h');
ylabel('Errore');
legend('Errore commesso', 'H');