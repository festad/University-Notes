function [tn,un]=eulero_esp(odefun,tspan,y0,Nh);
%   [tn,un]=eulero_esp(odefun,tspan,y0,Nh);
%   approssimazione del pdC del primo ordine con Eulero esplicito
%   funziona sia per equazioni scalari che per sistemi di equazioni.
%
%   tspan = [t0,T] integra il sistema di equazioni
%   differenziali y' = f(t,y) dal tempo t0 a T con
%   condizione iniziale y0 usando il metodo di Eulero
%   in avanti su una griglia equispaziata di Nh
%   intervalli.
%   La funzione ODEFUN(T,Y) deve ritornare un vettore
%   contenente f(t,y), della stessa dimensione di y.
%   Ogni riga del vettore soluzione un corrisponde ad
%   un istante temporale del vettore colonna tn.
%   

% costruisco il vettore dei tempi t_n
t0=tspan(1);
T=tspan(2);
tn=linspace(t0,T,Nh+1)';
% calcolo h
h=(T-t0)/Nh;

% 
y0=y0(:); % y0 sara' sempre vettore colonna
d=length(y0); % d= num. di eqz del sistema

% costruisco il vettore della soluzione numerica
un=zeros(Nh+1,d);


un(1,:)=y0.'; % .' realizza la trasposta sia che la variabile sia reale,
%                    sia che la variabile sia complessa

for n=1:Nh
    wn=un(n,:).';
    w=wn+h*odefun(tn(n),wn);
    un(n+1,:)=w.';
end

