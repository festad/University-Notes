function [z,k,res, ERR] = bisezione(f,a,b,tol,kmax)
  k = 0;
  err = 1 + tol;
  c = [];
  y = [];
  ERR = [err];
  
  while err > tol && k <= kmax
    c = (a+b)/2;
    y = f(c);
    err = (b-a)/2;
    ERR = [ERR;err];
    if y == 0
      err = 0;  
    else
      if y*f(a) < 0
        b = c;
      else
        a = c;
      end
      k = k+1;
    end  
  endwhile
  z = c;
  res = y;