% generazione di A
A = 3*eye(10);
A(1,:) = 1;
A(:,1) = 1;

figure(1);clf;
spy(A);
title('Spy su A');


% eseguo la fattorizzazione su A
[L,U,P] = fattorizzazione_lu_pivot(A);

figure(2);clf;
spy(L);
title('Spy su L');

figure(3);clf;
spy(U);
title('Spy su U');

% per matrici molto grandi si tende ad 
% evitare i metodi diretti, potrei esaurire la RAM

% potrei scambiare prima e decima colonna, 
% cosi' non avrei piu' il fill in,
% questo perche'

%%%%%%% seconda parte %%%%%%%%%

% generazione di A
A = 3*eye(10);
A(10,:) = 1;
A(:,10) = 1;

figure(1);clf;
spy(A);
title('Spy su A');


% eseguo la fattorizzazione su A
[L,U,P] = fattorizzazione_lu_pivot(A);

figure(2);clf;
spy(L);
title('Spy su L');

figure(3);clf;
spy(U);
title('Spy su U');

% le matrici L e U tengono la stessa struttura di partenza,
% non e' un caso...
% nel metodo di eliminazione di gauss si combinano
% la k-esima riga con la prima,
% se la matrice 