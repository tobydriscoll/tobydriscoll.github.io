% This short matlab codes implement the adaptive residual subsampling 
% method for radial basis function 1-D interpolation problem. 
%
% For reference, see:
% Adaptive residual subsampling methods for radial basis function
% interpolation and collocation problems. submitted to Computers Math. Appl
%
% Tobin A. Driscoll and Alfa R.H. Heryudono    05/14/2006
% MATLAB 7 is recommended.

thetar = 2e-5; thetac = 1e-8; N = 13;
f = @(x) 1./(1+25*x.^2);
phi = @(r,epsilon) sqrt((epsilon*r).^2 + 1);

fplot(f,[-1 1]); tp = title('','erasemode','xor'); hold on
fhandle = plot(1,0,'ko',1,0,'ko','MarkerSize',4);
x = linspace(-1,1,N)';
Nxx = 2001; xx = linspace(-1,1,Nxx)'; pp = f(xx);

refine = true;
while any(refine)
  N = length(x); dx = diff(x); 
  epsilon = 0.75*min([Inf;1./dx],[1./dx;Inf]);
  y = x(1:N-1) + 0.5*dx;
  
  [A,B,Axx]=deal(zeros(N),zeros(N-1,N),zeros(Nxx,N));
  for j=1:N
    A(:,j) = phi(x-x(j),epsilon(j)); 
    B(:,j) = phi(y-x(j),epsilon(j)); 
    Axx(:,j) = phi(xx-x(j),epsilon(j));
  end
  lambda = A\f(x); resid = abs(B*lambda - f(y)); 
  err = norm(Axx*lambda-pp,inf);
  
  % Plot
  set(tp,'string',sprintf('N = %3i,    Max error = %0.4e.',N,err));
  xdata = num2cell([x x]',2); ydata = num2cell([f(x) 0*x]',2);
  set(fhandle,{'xdata'},xdata,{'ydata'},ydata);
  drawnow
  
  % Refine
  refine = resid > thetar;
  fprintf('Adding %i centers.',sum(refine))
  x = sort([x;y(refine)]);
  
  % Coarsen
  coarsen = resid(1:N-2) < thetac & resid(2:N-1) < thetac;
  coarsen = 1+find(coarsen); x(coarsen) = [];
  fprintf(' Removing %i centers.\n',length(coarsen))
  disp('Press enter to continue'); pause
end
