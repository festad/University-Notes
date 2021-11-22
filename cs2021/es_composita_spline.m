f =@(x) 1./(1+x.^2);
xa = -5;
xb = +5;

x1 = linspace(xa,xb,1000)';
yf = f(x1);

ERR1 = []; % per p1c
ERR2 = []; % per le spline 
H = []; % per gli intervalli


for n = 10:10:500
H = [H, (xb-xa)/n] % intervallini tutti uguali
% interpolatore composito lineare
x = linspace(xa,xb,n+1);
y = f(x);
yp1c = interp1(x,y,x1); 
% spline
ys = spline(x,y,x1);

errp1c = norm(yf-yp1c,inf); ERR1 = [ERR1, errp1c];
errs = norm(yf-ys,inf);     ERR2 = [ERR2, errs];
fprintf("n=%d, errp1c=%e, errs=%e\n", n, errp1c, errs);
endfor

figure(2); clf;
loglog(H, ERR1, 'Linewidth', 2);
hold on;
loglog(H, ERR2, 'Linewidth', 2);
loglog(H, H.^2);
loglog(H, H.^4);
legend('Errore dell''interpolazione composita lineare', ...
'Errore delle spline', ...
'H^2', 'H^4');
xlabel('H');
ylabel('Errori');

##figure(1);clf;
##plot(x1,yf);
##hold on;
##grid on;
##plot(x1,yp1c);
##plot(x1,ys);
##legend('f(x)', 'interpolazione composita', 'spline');
##title(['Grado _{',num2str(n),'}']);
##pause(0.1)

% endfor

% plottare l'errore con loglog