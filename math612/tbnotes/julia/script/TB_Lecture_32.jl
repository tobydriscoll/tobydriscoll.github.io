
A = sprandn(10000,10000,0.0004);
whos()

using PyPlot
spy(A)
nnz(A)

v = rand(10000,1);
tic() 
for k = 1:100 
    A*v; 
end
toc()

F = full(A);
tic()
for k = 1:100
    F*v; 
end
toc()

B = A;
tic()
B[:,1000] = sum(B[:,1:10000],2); 
toc()

B = A;
tic()
B[1000,:] = sum(B[1:10000,:],1); 
toc()

n = 499;  
@show m = n^2
o = ones(m);
A = spdiagm((-o[1:m-n],-o[1:m-1],4o,-o[1:m-1],-o[1:m-n]),[-n -1 0 1 n],m,m);
b = ones(m);
tic() 
x = A\b; 
toc()

m = 20000;
A = sprandn(m,m,0.001) + m/100*speye(m);
b = ones(m);
dA = diag(A);
N = - triu(A,1) - tril(A,-1);
x = 0*b;
normres = [];
for k = 1:50
    x = (N*x + b)./dA;
    normres = [normres;norm(b-A*x)];
end
semilogy(normres,".-");
title("Convergence of Jacobi iteration")

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
    semilogy(normres,".-")
    mu = mu/4;
end
title("Convergence of Jacobi iteration")
