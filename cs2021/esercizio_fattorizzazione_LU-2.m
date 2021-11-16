A = [1,1+0.5e-15,3;
     2,2,20;
     3,6,4];

b = [5+0.5e-15;
     24;
     13];
%

[L,U] = fattorizzazione_lu(A)
y = backsub(L,b)

[L,U,P] = fattorizzazione_lu_pivot(A)
y = forsub(L,P*b)
x = backsub(U,y)



