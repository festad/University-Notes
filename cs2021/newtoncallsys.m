% definisco f1 e f2 come function handles

f1 =@ (x1,x2) x1.^2 - x2.^2 -1;
f2 =@ (x1,x2) x1.^2 + x2.^2 - 2*x1 - 3;

[x1,x2] = meshgrid(-3:0.1:3);
z1 = f1(x1,x2);
z2 = f2(x1,x2);

figure(1); clf;
surfc(x1,x2,z1); % superficie e linee di livello
                 % ma voglio la linea di livello
                 % anche a quota zero 
hold on;
contour(x1,x2,z1,[0,0],'b','Linewidth',2); % disegna tutte le contours tra quota
                         % zero e quota zero
                         
figure(2); clf;
surfc(x1,x2,z1);
hold on;
contour(x1,x2,z2,[0,0],'r','Linewidth',2);

figure(3); clf;
contour(x1,x2,z1,[0,0],'b','Linewidth',2);
hold on;
contour(x1,x2,z2,[0,0],'r','Linewidth',2);
grid on;
axis equal;

%% definizione input per Newton e chiamata di Newton

% dobbiamo usare una funzione vettoriale
% f che agisce su un vettore v

f =@ (x) [f1(x(1),x(2));...
          f2(x(1),x(2))];

% alternativa
% f =@ (x) [x(1)^2 - x(2)^2 - 1;...
%           x(1)^2 + x(2)^2 - 2*x(1) - 3];

Jf =@ (x) [2*x(1)   , -2*x(2);
           2*x(1)-2 , 2*x(2)];

tol = 1e-8; kmax = 100;
% x0 deve essere colonna perche' all'interno di newton
% x0 viene sommato a z per produrre xnew, z e' colonna
% quindi x0 deve essere compatibile con z
x0 = [3;
      2];

[zero,res,k,errv] = newtonsys(f,Jf,x0,tol,kmax)

figure(3); % senza clf
plot(zero(1),zero(2),'o');

% radice multipla
% z0 deve essere vettore colonna

x0 = [-2;
      1];

[zero,res,k,errv] = newtonsys(f,Jf,x0,tol,kmax)

figure(3); % senza clf
plot(zero(1),zero(2),'x');