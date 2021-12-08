function [tn,un] = heun(odefun,tspan, y0, Nh, varargin)
tn = linspace(tspan(1),tspan(2),Nh+1)'; % vettore dei tempi

h = abs(tspan(2)-tspan(1))/Nh; % passo di discretizzazione

un = zeros(Nh+1,1); % vettore della soluzione
un(1) = y0; % salvo la condizione iniziale

if nargin == 4
  tol = 1e-10;
  kmax = 10;
elseif nargin==5
  tol = varargin{1};
  kmax = 10;
elseif nargin == 6
  tol = varargin{1};
  kmax = varargin{2};
end

% ciclo
for i = 1:Nh
    un_star = un(i) + h*odefun(tn(i),un(i)); % fase di predizione 
                                             % con Eulero Esplicito
                                             
    % fase di correzione con 
    un(i+1) = un(i) + h/2*(odefun(tn(i),un(i)) + odefun(tn(i+1),un_star));
end
end