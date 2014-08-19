for n = 0:2
  for m = 1:3
    lambda(m,n+1) = fzero( @(x) besselj(n,x),3*m+n ); 
  end
end

x = @(r,theta) r.*cos(theta);
y = @(r,theta) r.*sin(theta);
for n = 0:2
  for m = 1:3
    subplot(3,3,n*3+m)
    phi = @(r,theta) besselj(n,lambda(m,n+1)*r).*cos(n*theta);
    ezsurf( x, y, phi, [0, 1, -pi, pi] );
    title(sprintf('J_%i, zero #%i',n,m))
    axis equal, shading interp
  end
end
