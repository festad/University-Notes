function [Imp] = trapezic(f,a,b,M)
  x = linspace(a,b,M+1);
  Imp = 0;
  H = (b-a)/M;
  for i=1:M
    xs = (x(i) + x(i+1))/2;
    ys = f(xs);
    Imp = Imp + f(x(i)) + f(x(i+1));
  endfor
  Imp = Imp*(H/2);
