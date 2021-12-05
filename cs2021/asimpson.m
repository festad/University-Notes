function [isa, NODI] = asimpson(f,a,b,tol,hmin)
  alpha = a; beta = b; isa = 0; NODI = [];
  while (beta-alpha) > 0
    I1 = simpsonc(f,alpha,beta,1);
    I2 = simpsonc(f,alpha,beta,2);
    stimatore = (1/15) * abs(I1 - I2);
    minorante = (tol/2) * ((beta-alpha)/(b-a));
    if stimatore > minorante && (beta - alpha) > hmin
      beta = (beta + alpha) / 2;
    else
      isa = isa + I2;
      nodilocali = linspace(alpha, beta, 5);
      NODI = [NODI; nodilocali];
      alpha = beta; beta = b;
    end
  endwhile
  NODI = unique(NODI);
  
end