% FORSUB driver
L = [2,0,0,0;
     1,1,0,0;
     3,2,4,0;
     0,-1,1,3];
b = [2;
     2;
     9;
     3];
     
x = forsub(L,b)

xmatlab = L\b