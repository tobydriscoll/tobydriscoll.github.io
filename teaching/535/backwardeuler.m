% Backward Euler method on a linear ODE (convergence study)

err = [];
u = [];
lambda = 200;

for N = [20 40 80 160 320 640 1280]

  t = linspace(0,3,N+1)';
  k = (3-0)/N;
  u(1) = 0;

  for n = 1:N
    u(n+1) = (u(n) + k*( cos(t(n+1)) + lambda*sin(t(n+1))) ) / (1+lambda*k);
  end
  
  err(end+1) = u(N+1)-sin(3);

end