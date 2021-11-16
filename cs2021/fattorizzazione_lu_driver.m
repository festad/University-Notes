A = [10,2,3,-2;
     2,20,20,-1;
     3,-6,4,3;
     -3,0,3,1];
     
b = [5;
     24;
     13;
     -2];
     
[L,U] = fattorizzazione_lu(A) % 2/3 * n^3

y = forsub(L,b) % e' l'ultimo output del meg, n^2
x = backsub(U,y) % n^2

xm = A\b

c = [10;
     -3;
     2;
     0];

% risolvo Az = c
% L*t = c, analogo di Lx = y, sistema triangolare inferiore
% U*z = t, y <- t, sistema triangolare superiore

t = forsub(L,c); % n^2
z = backsub(U,t) % n^2
