A = [10,4,3,-2;
     2,20,20,-1;
     3,-6,4,3;
     -3,0,3,1];
b = [5;
     24;
     13;
     -2];

% Fattorizzazione senza pivoting
[L,U] = fattorizzazione_lu(A);

% Risolvo Ly = b
y = backsub(L,b);

% La function matlab da' la stessa
% soluzione numerica che da' la nostra function,
% non la soluzione esatta,
% xm e' una soluzione numerica al pari di x

xm = A\b;

% Fattorizzazione con pivoting

[L,U,P] = fattorizzazione_lu_pivot(A);

y = forsub(L,P*b);
x = backsub(U,y);

% la matrice non e' a dominanza stretta diagonale,
% e non e' simmetrica, ma non ha 
% comunque avuto bisogno di pivotazione

