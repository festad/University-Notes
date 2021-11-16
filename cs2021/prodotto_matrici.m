function [prodotto] = prodotto_matrici(A,B)
  [na,ma] = size(A);
  [nb,mb] = size(B);
  
  if ma ~= nb
    prodotto = [];
    fprintf('Controllo sulle dimensioni fallito');
    return
  endif
  
  prodotto = zeros(na,mb);
  for k = 1:na
    for u = 1:mb
      prodotto(na,mb) = 0;
      for j = 1:nb % oppure ma
        prodotto(k,u) = prodotto(k,u) + A(k,j)*B(j,u);
      endfor
    endfor
  endfor
end % obbligatorio solo per piu' functions in un solo file

% OTTIMIZZAZIONE:
% c'e' una sola operazione interna a tre cicli
% matlab inserisce gli elementi per colonne invece che per righe,
% prima tutti gli elementi di una colonna, poi quelli di un'altra...
% tic; prodotto_matrici(); toc