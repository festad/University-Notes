function [z,res,k,ERR] = newton(f,df,x0,tol,kmax)
  err = tol + 1;
  k = 0;
  ERR = [err];
  
  while err > tol && k < kmax
    x_new = x0 - f(x0)./df(x0);
    err = abs(x_new - x0);
    ERR = [ERR;err];
    k = k+1;
    x0 = x_new;
  endwhile
  
  z = x_new;
  res = f(z);
