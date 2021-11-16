function [s] = somma(a,b)
% somma: sommo due vettori colonna
% [s] = somma(a,b)
% Input:  a,b: due vettori colonna della stessa dimensione
% Output: vettore somma

% questa linea non compare nell'help

  n = length(a); % max tra n righe e colonne dell'argomento

  s = zeros(n,1); % inizializzo un vettore s (n righe e 1 colonne) a zero
  % per una gestione efficiente della memoria
  for j = 1:n
    s(j) =  a(j) + b(j); % non serve dimensionare s,
    % matlab avvisa che s continua a cambiare dimensione
    % a ogni iterazione,
    % l'aggiunta in coda non e' efficacie dal pdv della gestione
    % della memoria
  endfor
  
  disp('La somma e'': '), s
