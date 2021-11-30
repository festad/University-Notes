function [tn,un] = eulero_esp(odefun,tspan, y0, Nh)
tn = linspace(tspan(1),tspan(2),Nh+1)'; % vettore dei tempi

h = abs(tspan(2)-tspan(1))/Nh; % passo di discretizzazione

un = zeros(Nh+1,1);
un(1) = y0;

for i = 1:Nh
    un(i+1) = un(i) + h*odefun(tn(i), un(i));
end
end
