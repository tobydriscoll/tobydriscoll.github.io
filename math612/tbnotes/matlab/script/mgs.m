function [Q,R] = mgs(A)
%   Modified Gram-Schmidt orthogonalization

[m,n] = size(A);
% we want to keep vpa intact if being used
Q = 0*A;
R = 0*A;  R = R(1:n,:);
for j = 1:n
    R(j,j) = norm(A(:,j));
    Q(:,j) = A(:,j)/R(j,j);
    R(j,j+1:n) = Q(:,j)'*A(:,j+1:n);
    A(:,j+1:n) = A(:,j+1:n) - Q(:,j)*R(j,j+1:n);
end

end