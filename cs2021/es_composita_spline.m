f =@(x) 1./(1+x.^2);
xa = -5;
xb = +5;

x1 = linspace(xa,xb,1000)';
yf = f(x1);

for n = 1:20
% interpolatore composito lineare
x = linspace(xa,xb,n+1);
y = f(x);
yp1c = interp1(x,y,x1);
% spline
ys = spline(x,y,x1);

errp1c = norm(yf-yp1c,inf);
errs = norm(yf-ys,inf);
fprintf("n=%d, errp1c=%e, errs=%e\n", n, errp1c, errs);

figure(1);clf;
plot(x1,yf);
hold on;
plot(x1,yp1c);
plot(x1,ys);
legend('f(x)', 'interpolazione composita', 'spline');
title(['Grado _{',num2str(n),'}']);
pause(0.1)

endfor

% plottare l'errore con loglog