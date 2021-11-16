function [x,relres,k,res]=bcgstab(A,b,x0,tol,kmax)
% CG metodo del Bi-CGStab
%  [X,RELRES,K,RES]=BCGSTAB(A,B,X0,TOL,KMAX)
%  risolve il sistema A*X=B con il metodo del Bi-CGStab.
%  X0 e` il vettore iniziale.
%  TOL specifica la tolleranza per il test d'arresto. 
%  KMAX indica il numero massimo di iterazioni ammesse.
%  RELRES e` la norma del residuo corrispondende alla
%  soluzione calcolata diviso la norma del vettore B.
%  K e` il numero di iterazioni effettuate dal metodo,
%  RES e` un vettore contenente la norma dei residui
%  (diviso la norma di b) ad ogni passo del metodo

k = 0;
bnorm = norm(b);
res=[ ];

if bnorm==0
x=zeros(n,1); relres=0;
else
x=x0;

r=b-A*x;   
rtilde0=r;

relres=norm(r)/bnorm;
alpha=1;rhom1=1;w=1;

while k<= kmax && relres> tol
rho=rtilde0'*r;
% rtilde0 e r risultano ortogonali, faccio un restart 
if rho==0
  rtilde0=r;
  rho=rtilde0'*r;
  relres=norm(r)/bnorm;
  alpha=1;rhom1=1;w=1;
  k=0;
end
if k==0
p=r;
else
beta=(rho/rhom1)*(alpha/w);
p=r+beta*(p-w*v);
end

v=A*p;
alpha=rho/(v'*rtilde0);
s=r-alpha*v;
if ( norm(s) < tol ) % early convergence check
        x = x + alpha*p;
        relres = norm( s ) / bnorm;
        break;
end
t=A*s;
w=(t'*s)/(t'*t);
x=x+alpha*p+w*s;
r=s-w*t;
rhom1=rho;
k=k+1;
nr=norm(r);
relres=nr/bnorm;
res=[res;relres];

end

end
