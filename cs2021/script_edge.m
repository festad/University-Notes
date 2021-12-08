A = imread('mozilla-logo-800', 'png');
figure(1); clf;
image(A)

% E' un array a tre indici, una sequenza di tre matrici
% rettangolari con 150r e 150c, ognuna delle quali
% contiene info relative ai tre colori rosso, verde, blu.

% Che dati sono contenuti? Tanti zeri e dei valori
% tipo 255, i valori sono interi tra 0 e 255,
% maggiore e' il valore riportato, piu' intenso e' il colore
% rappresentato da quella matrice.

% Il pixel associato a un particolare numero ha valore pari
% all'intensita' del blu, del rosso o del verde.

% Abbiamo una matrice per ogni colore.

% Per poter lavorare con le componenti della matrice A
% dobbiamo convertire il contenuto di A in double,
% se dobbiamo fare op di somma o divisione sforiamo il valore
% massimo 255, per esempio calcolando una media se la somma e' sopra
% 255 avrei un overflow. Devo prima convertie in double
% e poi ritornare a uint8.

% Ora salviamo separatamente le matrici convertendo in double.

[n,m, dim] = size(A);

R = double(A(:,:,1));
G = double(A(:,:,2));
B = double(A(:,:,3));

% Posso interpretare le matrici come tre funzioni in due dimensioni.

figure(2); clf;
mesh(R);
xlabel('x');ylabel('y');title('Red');
figure(3); clf;
mesh(G);
xlabel('x');ylabel('y');title('Green');
figure(4); clf;
mesh(B);
xlabel('x');ylabel('y');title('Blue');  

% genero le matrici delle differenze finite 
% DX e' una matrice m x n,
% e' sparsa quindi la generiamo con spdiags
e = 0.5*ones(m,1); % vettore di m elementi di valore 1/2
% la distanza tra due pixel e' 1
DX = spdiags([-e,e], [-1,1], m,m); % gli argomenti 
% sono i vettori colonna per le diagonali,
% -1 e 1 sono le posizioni delle diagonali, una e' quella prima e l'altra
% quella dopo la diagonale principale.

e = 0.5*ones(n,1);
DY = spdiags([-e,e], [-1,1], n,n);

% posso definire una nuova funzione che e' la media 
% delle intensita' di colore dei 3 colori RGB
Z = (R+G+B)/3;
% alla quale applico le derivate

DXZ = Z*DX;
DYZ = DY*Z;

% norma del gradiente 
NORMA_GRAD = sqrt(DXZ.^2 + DYZ.^2);
% contiene la norma del gradiente pixel per pixel

figure(5); clf;
mesh(NORMA_GRAD);

valore_medio = sum(sum(NORMA_GRAD))/(n*m);

% inizializzo una nuova matrice e la chiamo edge

edge = 255*uint8(ones(n,m));
% inizializzo una nuova matrice bianca e
% se ||grad|| > 2 * valore_medio metto il pixel nero
for i = 1:n
  for j = 1:m
    if NORMA_GRAD(i,j) > 2*valore_medio
      edge(i,j) = 0;
    end
  end
end

figure(6); clf;
image(edge);colormap(gray(256));

