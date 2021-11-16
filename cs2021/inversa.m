function [A1] = inversa(A)
  % INVERSA: A1 = inversa(a) calcola l'inversa di matrice con la fattorizzazione LU
  % Si suppone sia invertibile
  [n,m] = size(A);
  n = length(A); % prende la massima delle due
  
  A1 = zeros(n);
  
  [L,U,P] = fattorizzazione_lu_pivot(A);
  
  for j = 1:n
    % definisco il termine noto del sistema j-esimo
    e = zeros(n,10);
    e(j) = 1;
    % risolvo il sistema triangolare inferiore Ly = P*e
    y = forsub(L,P*e);
    % risolvo il sistema triangolare superiore Ux = y
    x = backsub(U,y);
    % salvo x nella colonna j-esima di A1
    A1(:,j) = x;
  endfor
