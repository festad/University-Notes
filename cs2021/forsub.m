function [x] = forsub(L,b)
  % FORSUB: foreword substitution to solve Lx = b
  % INPUT: L = square matrix triangular
  %        b = column vector, known value
  % OUTPUT: x = column vector, solution
  
  [n,m]   = size(L);
  [nb,mb] = size(b);
  if n ~= m || m ~= nb
    % either the matrix is not squared
    % or the number of columns of L is
    % different than the number of rows of b
    print('Attenzione, la matrice non e'' quadrata o il termine noto non e'' compatibile in dimensioni con L');
    x = [];
    return
  endif
  
  x = zeros(n,1);
  
  for i = 1:n
    % evaluation of the sum
    s = 0;
    for j = 1:(i-1)
      s = s + L(i,j)*x(j);
    endfor
    x(i) = (b(i)-s)/L(i,i);
  endfor
