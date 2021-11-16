function [x,res,k,resv] = gradiente_coniugato(A,b,x0,tol,kmax)
  % Metodo del gradiente
  % A = matric/ e quadrata simmetrica definita positiva
  %   b = termine noto
  %   x0 = vettore iniziale
  %   tol, kmax = tolleranza e n. massimo di iterazioni
  
  %   res = || r^k || / || b ||
  %   k = n. iterazioni
  %   resv = vettore dei valori || r^k ||
  
  x = x0;
  r = b - A*x; % residuo
  d = r; % direzione di discesa
  k = 0; % contatore delle iterazioni
  res = tol + 1; % stimatore dell'errore
  resv = norm(r);
  
  while k < kmax && res > tol
    v = A * d;
    alpha = (d' * r)/(d' * v);
    x = x + alpha*d;
    r = r - alpha*v;
    % d = r;
    beta = (v' * r)/(d' * v) % in r abbiamo gia' salvato il residuo
    % nel metodo del gradiente e' come se beta fosse 0
    d = r - beta*d;
    nr = norm(r)
    res = nr/norm(b);
    k = k + 1;
    resv = [resv;nr];
  endwhile

  