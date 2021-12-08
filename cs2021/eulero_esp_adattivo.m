function [tn,un]=eulero_esp_adattivo(odefun,tspan,y0,tol,hmin)

h = (tspan(2)-tspan(1))/10;
tn = tspan(1);

un = y0; % condizione iniziale
t = tn(1); 
w = un(1);

while t < tspan(2)
  [t1,un1] = eulero_esp(odefun,[t,t+h],w,1); % calcolo sull'intervallino,
                                            % un passo ampiezza h
  [t1,un2] = eulero_esp(odefun,[t,t+h],w,2) % due passi di ampiezza h/2
  % prendo solo le soluzioni nell'ultima componente
  w1 = un1(end);
  w2 = un2(end); 
  
  if abs(w1-w2) <= 0.5*max(abs(un))*tol || h < hmin
    % accetto la soluzione
    tn = [tn;t+h]; % aggiorno il vettore dei tempi
    un = [un;w2]; % aggiorno il vettore soluzione
    t = t+h;
    w = w2; 
    h = 2*h; % voglio che al passo successivo si parta con un h piu'
             % grande, altrimenti continuerebbe a ridursi
    
  else
    h = h/2;
  end
end


% 
y0=y0(:); % y0 sara' sempre vettore colonna
d=length(y0); % d= num. di eqz del sistema

% costruisco il vettore della soluzione numerica


un(1,:)=y0.'; % .' realizza la trasposta sia che la variabile sia reale,
%                    sia che la variabile sia complessa
