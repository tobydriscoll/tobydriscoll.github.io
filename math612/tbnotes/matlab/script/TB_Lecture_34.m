
m = 200;
rng(231)
A = [ randn(m-2,m-2), zeros(m-2,2); zeros(2,m-2), diag([23,20i]) ];
b = randn(m,1);  b = b/norm(b);
plot(eig(A),'.')
axis([-22 22 -22 22]), axis equal

[Q,H] = arnoldi(A,b,24);

[X,Y] = meshgrid(linspace(-25,25,100));
Z = X + 1i*Y;

plt = 1;
for n = 5:8
    subplot(2,2,plt)
    plot(eig(A),'.')
    axis([-25 25 -25 25]), axis equal
    hold on

    Hn = H(1:n,1:n);
    plot(eig(Hn),'r.')
    pn = poly(Hn);
    c = norm(polyvalm(pn,A)*b);
    W = polyval(pn,Z);
    contour(X,Y,abs(W),c*[1 1])
    title(sprintf('n = %i',n))
    axis off
    plt = plt+1;
end


plt = 1;
for n = 11:14
    subplot(2,2,plt)
    plot(eig(A),'.')
    axis([-20 20 -20 20]), axis equal
    hold on

    Hn = H(1:n,1:n);
    plot(eig(Hn),'r.')
    pn = poly(Hn);
    c = norm(polyvalm(pn,A)*b);
    W = polyval(pn,Z);
    contour(X,Y,abs(W),c*[1 1])
    title(sprintf('n = %i',n))
    axis off
    plt = plt+1;
end

for n = 1:24
    Hn = H(1:n,1:n);
    theta = eig(Hn);
    err(n,1) = min(abs(theta-23));
    err(n,2) = min(abs(theta-20i));
end
semilogy(err,'.-')

G = numgrid('S',100);
A = delsq(G);
m = length(A)

[V,D] = eigs(A,8);
whos D V

diag(D)

[V,D] = eigs(A,8,0);  % closest to zero
diag(D)

A = randn(50,50);   % close to normal
mu = max(abs(eig(A)));
A = A / (1.03*mu);  % ensure spectral radius < 1
[V,D] = eig(A);
cond(V)

B = triu(A);
mu = max(abs(diag(B)));
B = B / (1.03*mu);  % ensure spectral radius < 1
[V,D] = eig(B);
cond(V)

clf
M = {A,B};
for k = 1:2
    subplot(1,2,k);
    lam = eig(M{k});
    plot(real(lam),imag(lam),'x')
    hold on, axis equal
    for i = 1:40
        plot(eig(M{k}+0.01*randn(50)),'k.')
    end
end

clf
nrm = [];
for k = 1:2
    for n = 1:100
      nrm(n,k) = norm(M{k}^n);
    end
end

semilogy(nrm,'-o')

