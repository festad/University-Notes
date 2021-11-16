B = load('matriceB.mat').B;
autovalori = eig(B);
p = 1;
prodotti_parziali = zeros(1,length(autovalori));
for i = 1:length(autovalori)
  p = p*autovalori(i);
  prodotti_parziali(i) = p;
endfor
prodotti_parziali