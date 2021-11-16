function [point,err,niter]=fixedpoint(phi,x0,tol,nmax)
% FIXEDPOINT trova un punto fisso di una funzione
%   point=fixedpoint(phi,x0,tol,nmax) approssima il
%   punto fisso POINT della funzione definita nella 
%   function PHI partendo da X0.
%   PHI accetta in ingresso uno scalare x e
%   restituisce un valore scalare. Se la ricerca del
%   punto fisso fallisce, il programma restituisce un
%   messaggio d'errore. PHI puo' essere
%   inline function, anonymous function o function
%   definite in M-file.
%   [point,diff,niter]= fixedpoint(phi,x0,tol,nmax) 
%   restituisce
%   la differenza tra due iterate in valore assoluto 
%   (nella variabile DIFF) ed il numero di
%   iterazioni NITER necessario per calcolare POINT.
%
err=tol+1;
niter=0;
while niter<nmax && err>tol
   x=phi(x0);
   err=abs(x-x0);
   niter=niter+1;
   x0=x;
end
if (niter==nmax && err > tol)
  fprintf(['Fixed point si e'' arrestato senza aver ',...
    'soddisfatto l''accuratezza richiesta, avendo\n',...
    'raggiunto il massimo numero di iterazioni\n']);
end
point = x; 
return

