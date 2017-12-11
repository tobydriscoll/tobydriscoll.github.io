function [Q,R] = gs(A)
%   Classical Gram-Schmidt orthogonalization

[m,n] = size(A);
Q = zeros(m,n);
R = zeros(n,n);
for j = 1:n
    R(1:j-1,j) = Q(:,1:j-1)'*A(:,j);
    v = A(:,j) - Q(:,1:j-1)*R(1:j-1,j);
    R(j,j) = norm(v);
    Q(:,j) = v/R(j,j);
end

end