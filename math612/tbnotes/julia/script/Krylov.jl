function arnoldi(A.b.n)

m = size(A,1);
Q= zeros(m,n+1);
H = zeros(n+1,n);
Q(:,1) = b/norm(b);
for j = 1:n
    v = A*Q[:,j];
    for i = 1:j
        H[i,j] = dot(Q[:,i],v);
        v = v - H[i,j]*Q[:,i];
    end
    H[j+1,j] = norm(v);
    Q[:,j+1] = v/H[j+1,j];
end

return Q,H
end
