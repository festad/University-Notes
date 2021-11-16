intervallo = linspace(0.996, 1.004,10000);
p_1 =@(x) (x-1).^6;
p_2 =@(x) x.^6-6*x.^5+15*x.^4-20*x.^3+15*x.^2-6*x+1;
p_eff =@(x) 1+x.*(-6+x.*(15+x.*(-20+x.*(15+x.*(-6+x)))));

y_1 = p_1(intervallo);
y_2 = p_2(intervallo);
y_3 = p_eff(intervallo);

figure(1);clf;

plot(intervallo,y_2,'DisplayName','p_2(x)');
legend('-dynamiclegend');
hold on;
plot(intervallo,y_3,'DisplayName','p_{eff}(x)');
plot(intervallo,y_1,'DisplayName','p_1(x)');