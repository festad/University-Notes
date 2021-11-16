[r,theta] = meshgrid(0:.1:2, 0:.1:6*pi); %discretizzo r e theta
x = r.*cos(theta);
y = r.*sin(theta);
z = theta;

figure(1); clf;
surf(x,y,z);
%s.EdgeColor='none';
xlabel('x');
ylabel('y');
zlabel('z');
title('$\gamma(r,\theta)=(r\cos(\theta),r\sin(\theta),\theta)$',...
 'Interpreter','Latex');
