function [L,U] = fattorizzazione_lu(A)
  % FATTORIZZAZINOE_LU: calcolo la fattorizzazione LU di A
  % INPUT:  A = matrice quadrata non singolare
  % OUTPUT: L = matrice triangolare inferiore
  %         U = matrice triangolare superiore
  %         tale che A = L * U
  % x = meg(A,b)
  
  [n,m] = size(A);
  if n~=m
    disp('Attenzione! A non e'' quadrata');
    return
  endif

  for k=1:(n-1) % ciclo sul passo
    for i=k+1:n % ciclo sulle righe per l'eliminazione
      % calcolo del moltiplicatore
      if A(k,k) == 0
        disp('Attenzione! Il termine diagonale e'' nullo');
        return
      endif
      A(i,k) = A(i,k)/A(k,k);
      for j=k+1:n % ciclo sulle colonne di A
        A(i,j) = A(i,j) - A(i,k)*A(k,j);
      endfor
      % b(i) = b(i) - mik*b(k); % aggiornamento del termine noto
    endfor
  endfor

  U = triu(A); % matrice triangolare superiore il cui triangolo superiore
               % contiene il triangolo superiore di A, inclusa
               % la diagonale principale
  L = tril(A,-1) + eye(n); % eye e' la diagonale