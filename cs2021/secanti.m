function [z,res,k,ERR] = secanti(f,x0,x1,tol,kmax)
  err = tol + 1;
  k = 0;
  ERR = [err];
  
  while err > tol && k < kmax
    x2 = x1 - f(x1)/((f(x1)-f(x0))/(x1-x0));
    err = abs(x2-x1);
    ERR = [ERR;err];
    k = k+1;
    x0 = x1;
    x1 = x2;
  endwhile
  
  z = x2;
  res = f(z);
