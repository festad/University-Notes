f =@(x,y,t) sin(sqrt(x.^2+y.^2)-2*t);
[x,y] = meshgrid(-2*pi:0.5:2*pi); % con un solo argomento la discretizzazione
                                  % e' uguale per x e y
nframes = 50; % n istanti temporali
tt = linspace(0,2*pi,nframes); %discretizzazione del tempo
figure(1); clf;

for n = 1:nframes % indice del tempo
  t = tt(n); % tempo
  z = f(x,y,t);
  s = surf(x,y,z);
  axis([-2*pi,2*pi,-2*pi,2*pi,-2,2]); % fisso il box grafico
  xlabel('x');
  ylabel('y');
  title(['t=',num2str(t)]);
  Mv(n)=getframe;
  pause(0.01);
end

movie(Mv,4);