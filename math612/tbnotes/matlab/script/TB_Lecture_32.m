
A = sprandn(10000,10000,0.0004);
whos A

spy(A)
nnz(A)

v = rand(10000,1);
tic, for k = 1:100, A*v; end, toc

F = full(A);
tic, for k = 1:100, F*v; end, toc

B = A;
tic, B(:,1000) = sum(B(:,1:10000),2); toc

B = A;
tic, B(1000,:) = sum(B(1:10000,:),1); toc

grid = numgrid('S',500);
A = delsq(grid);
spy(A)

n = size(A,1); 
b = ones(n,1);
tic, x = A\b; toc

m = 20000;
A = sprandn(m,m,0.001) + m/100*speye(m);
b = ones(m,1);
dA = diag(A);
N = - triu(A,1) - tril(A,-1);
x = 0*b;
normres = [];
for k = 1:50
    x = (N*x + b)./dA;
    normres = [normres;norm(b-A*x)];
end
semilogy(normres)
title('Convergence of Jacobi iteration')

mu = sqrt(m);
for i = 1:4
    A = sprandn(m,m,0.001) + mu*speye(m);
    dA = diag(A);
    N = - triu(A,1) - tril(A,-1);
    x = 0*b;
    normres = [];
    for k = 1:50
        x = (N*x + b)./dA;
        normres = [normres;norm(b-A*x)];
    end
    semilogy(normres)
    hold on
    mu = mu/4;
end
title('Convergence of Jacobi iteration')
