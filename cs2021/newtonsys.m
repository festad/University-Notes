function[zero,res,k,errv] = newtonsys(f,J_f,x_0,tol,kmax)
% Newton per sistemi di equazioni non lineari


k = 0;
err = tol + 1;
errv = [err]; % inizializzo la lista degli errori

while k < kmax && err > tol
  b = -f(x_0);
  A = J_f(x_0); % J_f e' una matrice di funzioni,
                % f invece e' un vettore di funzioni,
  z = A\b; % risolvo Az = b
  x_new = x_0 + z;
  err = norm(z);
  errv = [errv;err];
  k = k + 1;
  x_0 = x_new;
end

zero = x_new;
res = f(zero);
