function lam = inviter(A,mu)

m = length(A);
I = eye(m);
v = randn(m,1);
for k = 1:40
    w = (A-mu*I)\v;
    v = w/norm(w);
    lam(k) = v'*A*v;
end