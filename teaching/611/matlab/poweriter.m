function lam = poweriter(A)

m = length(A);
v = randn(m,1);
for k = 1:40
    w = A*v;
    v = w/norm(w);
    lam(k) = v'*A*v;
end