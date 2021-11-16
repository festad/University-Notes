% dati_letto_griglia: definisce i dati e la matrice del grafo del 
% Problema ``Un letto a griglia''
L=0.5; % lunghezza dei capillari (mm)
r=2.5e-3; % raggio dei capillari (mm)
mu=1.9e-3; % viscosita' del sangue g/(mm*s) 
pa=40; pv=15; % pressione nell'arteriola e nella venula (mmHg)
R=8*mu/(pi*r^4); % resistenza nei capillari g/(mm^5*s) 
Area=pi*r^2; % Area della sezione dei capillari
if ~(exist('nc','var')) % controlliamo che nc sia definita
    nc=4; % numero di capillari lungo ogni direzione del grafo
end
m=nc+1; % m = numero di nodi lungo ogni direzione
% G = matrice del grafo con le lunghezze dei capillari
n=m*m+2;  G=zeros(n);
G(1,2)=L; G(2,1)=G(1,2);
for ir=1:m
    for ic=1:m
        i=(ir-1)*m+ic+1;
    if ic <= m-1
        G(i,i+1)=L; G(i+1,i)=G(i,i+1);
    end
    if ir <= m-1
        G(i,i+m)=L; G(i+m,i)=G(i,i+m);
    end
end
end
G(n-1,n)=L; G(n,n-1)=G(n-1,n);
disp('I dati del problema ``Un letto a griglia`` sono stati definiti')
