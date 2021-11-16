function [successione, errori_relativi] = successione_pigreco(N)
  fn =@ (x, fnp) 2^(x-0.5)*sqrt(1-sqrt(1-4^(1-x)*fnp^2));
  pigreco = [];
  successione = zeros(N,1);
  errori_relativi = zeros(N,1);
  errori_relativi(1) = 1;
  if N < 2
    successione = [];
    errori_relativi = [];
    return
  endif

  successione(2) = 2;
  errori_relativi(2) = abs(pi-2)/pi;
  
  for i = 2:N
    successione(i+1) = fn(i,successione(i));
    errori_relativi(i+1) = abs(pi-successione(i+1))/pi;
  endfor
  figure(1);clf;
  plot(successione, '*');
  figure(2);clf;
  plot(errori_relativi,'*');
  
  % verso 30 inizia ad andare in merda
