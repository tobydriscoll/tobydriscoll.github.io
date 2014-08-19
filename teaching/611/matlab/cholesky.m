function R = cholesky(A)

m = length(A);
for k = 1:m
    for j = k+1:m
        A(j,k:m) = A(j,k:m) - (A(j,k)/A(k,k))*A(k,k:m);
    end
    gamma = 1/sqrt(A(k,k));
    A(k,k:m) = gamma*A(k,k:m);
end
R = triu(A);
