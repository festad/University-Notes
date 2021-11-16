function [A,b]=setup_system(G,pa,pv)
% [A,b]=pressioni(G,pa,pv) calcola le pressioni per un letto di capillari
% Input:  G = matrice del grafo
%         pa, pv = pressioni nell'arteriola e nella venula 
% Output: A = martice del sistema lineare
%         b = termine noto

% Costruiamo la matrice A ...
n=length(G); A=sparse(n); A(1,1)=1; A(n,n)=1;
for i=2:n-1
    for j=1:n
        if G(i,j)~=0
        A(i,j)=-1/G(i,j);
        A(i,i)=A(i,i)+1/G(i,j);
        end
    end
end
b=zeros(n,1); b(1)=pa; b(n)=pv; % ...e il termine noto
 
end
