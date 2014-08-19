% Arnoldi iteration, with Ritz values shown.

A = randn(200);
A = blkdiag(A,[21 0;0 -18]);

MaxN = 50;

% Prepare plot.
figure
e = eig(A);
plot(e+eps*i,'k.')
hold on
han1 = plot(NaN,NaN,'ro');
axis equal
pause

[Q,H] = arnoldi(A,MaxN+1);

% Find Ritz values
ritz = NaN*zeros(MaxN,MaxN);
for n = 1:MaxN
  theta = eig(H(1:n,1:n));
  set(han1,'xdata',real(theta),'ydata',imag(theta))
  ritz(1:n,n) = sort(theta,1,'descend');
  title(sprintf('n = %i',n))
  pause(0.2)
end

