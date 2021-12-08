function [tn,un] = eulero_imp_s(odefun,tspan, y0, Nh, varargin)
tn = linspace(tspan(1),tspan(2),Nh+1)'; % vettore dei tempi

h = abs(tspan(2)-tspan(1))/Nh; % passo di discretizzazione

y0=y0(:); % y0 sara' sempre vettore colonna
d=length(y0); % d= num. di eqz del sistema

% costruisco il vettore della soluzione numerica
un=zeros(Nh+1,d);


un(1,:)=y0.'; % .' realizza la trasposta sia che la variabile sia reale,
%                    sia che la variabile sia complessa

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



B0 = eye(d); % approssimazione della matrice Jacobiana
% di r nel punto iniziale per il metodo di Broyden
% ciclo
for i = 1:Nh
    wn = un(i,:).';
    r =@(x) x - wn - h*odefun(tn(i+1),x);
    [z,res,it] = broyden(r,B0,wn,tol,kmax);
    % un(i+1) = un(i) + h*odefun(tn(i), un(i));
    un(i+1, :)=z.';
end
end