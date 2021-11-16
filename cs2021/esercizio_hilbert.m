% esercizio sulla matrice di Hilbert

n = 29;
A = hilb(n);
K = cond(A);

% costruisco il termine noto b = A*[1;1;...]

b = A * ones(n,1);

% stimiamo l'errore 
err = K * eps/2; % l'unita' di roundoff e' precisione macchina / 2

x = meg(A,b);

% errore reale

err_reale = norm(x-ones(n,1)/norm(ones(n,1)))