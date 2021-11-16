x = [0:24]';
y = [164.05, 73.72, 23.39, 17.11, 20.31, 29.37, 74.74 ...
     117.02, 298.04, 348.13, 294.75, 253.78, 250.48 ...
     239.48, 236.52, 245.04, 286.74, 304.78, 288.76 ...
     247.11, 216.73, 185.78, 171.19, 171.73, 164.05]';

omega = 2*pi/24;

n = 9;
m = 25;

X = [x.^8, x.^7, x.^6, x.^5, x.^4, x.^3, x.^2, x, ones(m,1)];

[Q,R] = qr(X);

Qtilde = Q(:,1:n);
Rtilde = R(1:n,:);

a = Rtilde\Qtilde'*y;

figure(1); clf;
plot(x,y,'b*');
grid on;
hold on;
x1 = linspace(x(1),x(end),100)';
y1 = polyval(a,x1);
yr = polyval(a, x);
plot(x1, y1, 'r-', 'Linewidth',2);
title('Monossido di azoto');
xlabel('Ora: 0-24');
ylabel('Concentrazione di monossido d''azoto');

% Rappresentazione con SIN e COS

SINCOS = [ones(m,1), sin(omega*x), cos(omega*x), sin(2*omega*x), cos(2*omega*x), ...
                     sin(3*omega*x), cos(3*omega*x), sin(4*omega*x), cos(4*omega*x)];

[Q1,R1] = qr(SINCOS);

Qtilde1 = Q1(:,1:n);
Rtilde1 = R1(1:n,:);

a1 = Rtilde1\Qtilde1'*y;

g1 =@ (x) a1(1) + a1(2)*sin(omega*x) + a1(3)*cos(omega*x) + ...
                   a1(4)*sin(2*omega*x) + a1(5)*cos(2*omega*x) + ...
                   a1(6)*sin(3*omega*x) + a1(7)*cos(3*omega*x) + ...
                   a1(8)*sin(4*omega*x) + a1(9)*cos(4*omega*x);
%
yfourier = g1(x1);

plot(x1,yfourier,'g-', 'Linewidth', 2);
legend('Misurazione', 'Parabola di regressione', 'Serie di Fourier');
