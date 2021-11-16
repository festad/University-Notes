A = [324,-45,246,-162,-9;
     -45,1048,442,96,113;
     246,442,435,-183,30;
     -162,96,-183,387,60;
     -9,113,30,60,20];
b = [615;
     2736;
     1838;
     -360;
     247];
%
eig(A)
% gli autovalori sono tutti positivi

x0 = rand(5,1);
tol = 10e-8;
kmax = 500;

[x1,res1,k1,resv1] = gradiente(A,b,x0,tol,kmax);

[x2,res2,k2,resv2] = gradiente_coniugato(A,b,x0,tol,kmax);

figure(1);clf
semilogy(0:k1,resv1,'*b',0:k2,resv2,'*r');
grid on;
legend('Metodo del gradiente', 'Metodo del gradiente coniugato');

fprintf('Il numero di condizionamento della matrice A e'' %3.3f \n\n', cond(A));
