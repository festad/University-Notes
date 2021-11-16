function [x] = meg(A,b)
  % MEG: risoluzione di Ax = b con il metodo di eliminazione di Gauss
  % INPUT:  A = matrice quadrata non singolare
  % OUTPUT: x = vettore soluzione
  % x = meg(A,b)
  
  [n,m] = size(A);
  if n~=m
    disp('Attenzione! A non e'' quadrata');
    return
  endif

  [nb,mb] = size(b);
  if nb ~= n
    disp('Attenzione! b non e'' compatibile con le dimensioni di A');
    return
  endif

  for k=1:(n-1) % ciclo sul passo
    for i=k+1:n % ciclo sulle righe per l'eliminazione
      % calcolo del moltiplicatore
      if A(k,k) == 0
        disp('Attenzione! Il termine diagonale e'' nullo');
        return
      endif
      mik = A(i,k)/A(k,k);
      for j=k+1:n % ciclo sulle colonne di A
        A(i,j) = A(i,j) - mik*A(k,j);
      endfor
      b(i) = b(i) - mik*b(k); % aggiornamento del termine noto
    endfor
  endfor

  U = triu(A); % matrice triangolare superiore il cui triangolo superiore
               % contiene il triangolo superiore di A, inclusa
               % la diagonale principale
  x = backsub(U,b);