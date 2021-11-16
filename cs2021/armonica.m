function [somma,vettore_somme] = armonica(n)
  vettore_somme     = zeros(n,1);
  somma = 0;
  for j = n:-1:1 % per non accumulare errori di arrotondamento,
    % partiamo dall'addendo piu'' piccolo a quello piu'' grande
    somma = somma + 1/j;
    vettore_somme(j)  = somma;
  endfor
  
  fprintf('La somma e'' %8.6f\n', somma);
