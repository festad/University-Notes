A = [10,100,3,-2;
     2,20,20,-1 ;
     3,-6,4,3;
     -3,0,3,1];

b = [5;
     24;
     13;
     -2];

%x = meg(A,b)
x = meg_pivot(A,b)