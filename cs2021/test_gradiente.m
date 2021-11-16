% call gradiente
A = [6,1,-2,2,1;
     1,3,1,-2,0;
     -2,1,4,-1,-1;
     2,-2,-1,4,2;
     1,0,-1,2,3];
%

b = [15;
     2;
     3;
     21;
     21];
%

x0 = zeros(5,1);
tol = 1e-12;
kmax = 500;

[x,res,k,resv] = gradiente(A,b,x0,tol,kmax)

%% 
figure(1);clf;
semilogy(0:k,resv,'Linewidth',2);
grid on;
xlabel('k');
ylabel('Residui del gradiente');
% title('Metodo del gradiente');
hold on;

%%
[x1,res1,k1,resv1] = gradiente_coniugato(A,b,x0,tol,kmax);

figure(1);
semilogy(0:k1,resv1,'Linewidth',2);
grid on;
xlabel('k');
ylabel('Residui del gradiente');
title('Metodi del gradiente');
legend('Metodo del gradiente', 'Metodo del gradiente coniugato');


