function [L,U,P] = fattorizzazione_lu_pivot(A)
  % FATTORIZZAZINOE_LU: calcolo la fattorizzazione LU di A
  % INPUT:  A = matrice quadrata non singolare
  %         pivot = 0 -> non faccio la pivotazione
  %         pivot = 1 -> eseguo la pivotazione
  % OUTPUT: L = matrice triangolare inferiore
  %         U = matrice triangolare superiore
  %         tale che A = L * U
  %         P tiene conto degli scambi di righe di pivotazione
  % x = meg(A,b)
  
  [n,m] = size(A);
  if n~=m
    disp('Attenzione! A non e'' quadrata');
    return
  endif
  
  %%%% pivotazione %%%%
  
  % inizializzo la matrice P che memorizza le informazioni sulla pivotazione
  
  P = eye(n);
  
  pivot = 1;

  for k=1:(n-1) % ciclo sul passo
    if pivot
      [~,r] = max(abs(A(k:n, k))); % r e' la posizione relativamente 
                                   % al sottovettore che parte da riga k
      r = r + (k-1); % posizione all'interno della matrice
      % scambio delle righe di A
      temp = A(k,:);
      A(k,:) = A(r,:);
      A(r,:) = temp;
      
      temp = P(k,:);
      P(k,:) = P(r,:);
      P(r,:) = temp;
    endif
    
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