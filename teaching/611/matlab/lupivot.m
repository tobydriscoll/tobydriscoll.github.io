function [L,U,P] = lupivot(A)

m = length(A);
L = eye(m);
P = eye(m);
for k = 1:m-1
    [tmp,J] = max( abs(A(k:m,k)) );
    J = k-1+J;
    A([k J],:) = A([J k],:);
    L([k J],1:k-1) = L([J k],1:k-1);
    P([k J],:) = P([J k],:);
    for j = k+1:m
        L(j,k) = A(j,k)/A(k,k);
        A(j,k:m) = A(j,k:m) - L(j,k)*A(k,k:m);
    end
end
U = triu(A);
