%y1 e y2 complicate
y1 =@ (x) 1/3*log(x/2)+x.^2;
y2 =@ (x) (x.^2+x-1);
% differenza tra le due funzioni
diff =@ (x) 1/3*log(x/2) - x + 1;

x = linspace(0.0001,1,1000);
y = diff(x);
figure(1);clf;
plot(x,y);
grid on;
hold on;

df   =@ (x) 1./(3*x)-1;
dy = df(x);
tol  = 1e-8;
kmax = 50;
x0   = 0.001;
x_l = 0.05;
x_r = 0.45;
[z,res,k,ERR] = newton(diff,df,x_l,tol,kmax)
[z2,res2,k2,ERR2] = newton(diff,df,x_r,tol,kmax)

plot(z,res,'xr',  z2,res2,'xr');

phi_1 =@ (x) 1/3*log(x/2) + 1;
phi_2 =@ (x) 2*e.^(3*(x-1));

phi_1_y = phi_1(x);
phi_2_y = phi_2(x);

figure(2);clf;
plot(x,phi_1_y,'r-',  x,phi_2_y,'b-',  x,x,'k-');
legend('phi_1(x)', 'phi_2(x)', 'y=x');

fprintf('phi_1(x), x_0 = 0.05\n');
[point,err,niter] = fixedpoint(phi_1, x_l, tol, kmax)
fprintf('\nphi_1(x), x_0 = 0.45\n');
[point,err,niter] = fixedpoint(phi_1, x_r, tol, kmax)
fprintf('\nphi_2(x), x_0 = 0.05\n');
[point,err,niter] = fixedpoint(phi_2, x_l, tol, kmax)
fprintf('\nphi_2(x), x_0 = 0.45\n');
[point,err,niter] = fixedpoint(phi_2, x_r, tol, kmax)

d_phi_1 =@ (x) 1./(3*x);
d_phi_2 =@ (x) 6*e.^(3*(x-1));

fprintf('\nDerivative of phi_1 in %2.2f -> %2.2f', z, d_phi_1(z));
fprintf('\nDerivative of phi_1 in %2.2f -> %2.2f', z2, d_phi_1(z2));
fprintf('\nDerivative of phi_2 in %2.2f -> %2.2f', z, d_phi_2(z));
fprintf('\nDerivative of phi_2 in %2.2f -> %2.2f\n', z2, d_phi_2(z2));






