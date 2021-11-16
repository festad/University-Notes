function [v]=velocita(p,G,R,Area)
% velocita(G,p,R) calcola e disegna le velocita` 
% per un letto di capillari
% Input:  G = matrice del grafo
%             (le lunghezze degli archi sono in mm)
%         p = vettore delle  pressioni nei nodi del letto (in mmHg)
%         R = resistenza nei capillari (in g/(mm^5 s) )
% Output: velocita' nei capillari del letto (mm/s)

n=length(p); % determiniamo il numero di nodi del letto
Q=zeros(n);  % inizializziamo la matrice delle portate
% calcoliamo le portate e le stampiamo
for i=1:n  % ciclo sui nodi
    for j=1:n  % ciclo sui nodi 
        if G(i,j)~=0
% se i nodi i e j sono connessi, calcolo la portata Q_ij 
        Q(i,j)=133.32*abs(p(i)-p(j))/(R*G(i,j));
        v(i,j)=Q(i,j)/Area;
        end
    end
end
disegna_letto_griglia(G,p,v)
return

function disegna_letto_griglia(G,p,v)
% disegna_letto_griglia(G,p,v), disegna le pressioni e le vel medie
% del letto capillare con grafo a griglia
% Input: G = matrice del grafo
%        p = vettore delle pressioni nei nodi
%        v = matrice delle velocita` medie nei capillari
n=length(G);
m=sqrt(n-2);
L=G(1,2);
% costruisco i nodi della rete
x=zeros(n,1); y=x;
x(1)=-L/sqrt(2); y(1)=L/sqrt(2);
for i1=1:m
    for i2=1:m
        i=(i2-1)*m+i1+1;
    x(i)=L*(i1-1);
    y(i)=-L*(i2-1);
    end
end

x(n)=x(n-1)+L/sqrt(2);
y(n)=y(n-1)-L/sqrt(2);
x=x+abs(min(x)); y=y+abs(min(y));
x=x/max(abs(x)); y=y/max(abs(y));
xy=[x,y];

np=32;
colore=zeros(np,3);
v2=linspace(0,1,np);
colore(1:np,1)=v2;
v1=linspace(1,0,np);
colore(:,3)=1;
colore(1:np,3)=v1;


% disegno la pressione
figure(1); clf
for i=1:n
for j=i+1:n
    if G(i,j)~=0
x1=[x(i),(x(i)+x(j))/2,x(j)];
y1=[y(i),(y(i)+y(j))/2,y(j)];
p1=[p(i),(p(i)+p(j))/2,p(j)];
patch([x1 nan],[y1 nan] ,[p1,nan], [p1,nan],...
   'EdgeColor','interp','FaceColor','none','Linewidth',2);
hold on
    end
end
end
grid on

colormap(colore)
view([-51,16])
axis([min(x),max(x),min(y),max(y),min(p),max(p)])
daspect([xy(end,1),xy(end,1),40])
t1=text(1,0.42,min(p)-4,'venula','Fontsize',16);
t2=text(-0.21, 0.88, max(p)+7,'arteriola','Fontsize',16);
zlabel('pressione (mmHg)','Fontsize',16)
colorbar
set(gca,'Fontsize',16)

% disegno le velocita`
figure(2); clf

cmap=colormap(hsv(32));

vmin=100;
for i=1:n
    for j=1:n
        if v(i,j)>0
vmin=min([vmin,v(i,j)]);
        end
    end
end
vcolore=zeros(size(v));
ncolor=size(cmap,1);
vmax=max(max(v))*1.05;
for i=1:n    for j=1:n
        if v(i,j)>0
vcolore(i,j)=round(1+(v (i,j)- vmin)*(ncolor-1)/(vmax-vmin));
        end
    end
end

% 
i=1;
for j=i+1:n
        if G(i,j)~=0
patch([x(i),x(j),x(j),x(i)],[y(i),y(j),y(j),y(i)] ,...
      [v(i,j),v(i,j),0,0], cmap(vcolore(i,j),:));
hold on
        end
end

for i1=1:m
    for i2=1:m
    i=(i2-1)*m+i1+1;
        for j=i+1:n
        if G(i,j)~=0
 patch([x(i),x(j),x(j),x(i)],[y(i),y(j),y(j),y(i)] ,...
      [v(i,j),v(i,j),0,0], cmap(vcolore(i,j),:));
       end
        end
    end
end
colorbar
view([-46,26])
daspect([xy(end,1),xy(end,1),2])
grid on
zlabel('vel. medie (mm/s)','Fontsize',16)
t1=text(0.88,0.08,v(1,2)+0.2,'venula','Fontsize',16);
t2=text(0,1,v(end-1,end)+0.2,'arteriola','Fontsize',16);
set(gca,'Fontsize',16)

axis([min(x),max(x),min(y),max(y),0,1])
caxis([vmin,vmax])

