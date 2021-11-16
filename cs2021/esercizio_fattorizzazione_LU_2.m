A = [1,1+0.5e-15,3;
     2,2,20;
     3,6,4];

b = [5+0.5e-15;
     24;
     13];

% senza pivoting
[L,U] = fattorizzazione_lu(A)
y = forsub(L,b)
x = backsub(U,y)

% con pivoting
[L1,U1,P1] = fattorizzazione_lu_pivot(A)
y1 = forsub(L1,P1*b)
x1 = backsub(U1,y1)

% meglio fare sempre con la pivotazione
% perche' evita errori grossi di arrotondamento

