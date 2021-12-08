function [zero,res,niter,Err]=broyden(fun,B0,x0,varargin)
%BROYDEN Trova uno zero di un sistema di funzioni.
%   [ZERO,RES,NITER,ERR]=BROYDEN(FUN,B0,X0) 
%   [ZERO,RES,NITER,ERR]=BROYDEN(FUN,B0,X0,TOL) 
%   [ZERO,RES,NITER,ERR]=BROYDEN(FUN,B0,X0,TOL,KMAX) 
%   [ZERO,RES,NITER,ERR]=BROYDEN(FUN,B0,X0,TOL,KMAX,PFLAG) 
%   approssima la soluzione del sistema di funzioni
%   definite nella function FUN, usando il metodo di 
%   Broyden partendo da X0, dove B0 e' l'approssimazione
%   dello Jacobiano al passo 0. FUN accetta in ingresso
%   un vettore x e restituisce un vettore della stessa
%   dimensione. Se la ricerca dello zero fallisce, il
%   programma restituisce un messaggio d'errore.
%   FUN puo' essere un function handle o una 
%   function definita in M-file.
%   TOL e` la tolleranza per il test d'arresto, 
%       valore di default TOL=1e.-8
%   KMAX e` il num. massimo di iterazioni, 
%       valore di default KMAX=50
%   se PFLAG =1 viene stampato messaggio di convergenza,
%      altrimenti no,
%       valore di default PFLAG=0
%   ZERO e' l'approssimazione della radice cercata
%   RES e' la norma del residuo all'ultima iterazione,  
%   NITER sono le iterazioni effettuate, mentre
%   ERR  e' il vettore degli errori (sull'incremento):
%   ERR(k)=||x^(k+1)-x^(k)||_2
if nargin==3
    tol=1.e-8; kmax=50; pflag=0;
elseif nargin==4
    tol=varargin{1};
    kmax=50; pflag=0;
elseif nargin==5
    tol=varargin{1};
    kmax=varargin{2};
    pflag=0;
else 
    tol=varargin{1};
    kmax=varargin{2};
    pflag=varargin{3};
end
fx0 = fun(x0);
niter = 0; 
err = tol+1;
Err=[err];
while err >= tol && niter < kmax
s=-B0\fx0; 
x1=x0+s; 
fx1=fun(x1);
B0=B0+(fx1*s')/(s'*s);
niter = niter + 1; 
err = norm(s);
Err=[Err;err];
x0=x1; fx0=fx1;
end
zero = x1; res = norm(fx1);
if pflag
if (niter==kmax && err > tol)
  fprintf(['Broyden si e'' arrestato senza aver ',...
   'soddisfatto l''accuratezza richiesta, avendo\n',...
   'raggiunto il massimo numero di iterazioni\n']);
else
    fprintf(['Il metodo converge in %i iterazioni',...
            ' con un residuo pari a %e\n'],niter,res);
end
end
return
