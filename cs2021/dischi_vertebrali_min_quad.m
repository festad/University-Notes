x = [0.00, 0.04, 0.06, 0.10, 0.14, 0.25, 0.31]';
y = [0.00, 0.03, 0.08, 0.08, 0.14, 0.20, 0.23]';

n = 2;
m = length(x);

X = [x, ones(m,1)]; % colonna corrispondente
% alle potenze di x

% calcolare la fattorizzazione QR della matrice grande
% estrarre Q~ e R~.
% risolvere il sistema 

[Q,R] = qr(X);

Qtilde = Q(:,1:n);
Rtilde = R(1:n,:);

a = backsub(Rtilde, Qtilde'*y);

figure(1); clf;
plot(x,y,'bo');
grid on;
hold on;

% yg = polyval(a,x);

yg = polyval(a,x);