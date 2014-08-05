A = [ 1 -2 0 0 0 0;
-2 1 -2 0 0 0;
0 -2 1 -2 0 0;
0 0 -2 1 -2 0;
0 0 0 -2 1 -2;
0 0 0 0 -2 1]
n = 10;
A = zeros(n,n);   % all zeros n by n
for i = 1:n
    for j = 1:n
        if i==j      % test equality
            A(i,j) = 1;  % Assign to (i,j) element
        elseif abs(i-j)==1
            A(i,j) = -2;
        else
            A(i,j) = 0;
        end  % if
    end
end
A
diag(1:3)   % put the elements on the diagonal of a new matrix
diag(1:3,1)   % put the elements on the 1st superdiagonal
n = 10;
ones(n,1)  % vector of all ones
A = diag(ones(n,1)) + diag( -2*ones(n-1,1),1 ) + diag( -2*ones(n-1,1),-1 )
A = toeplitz([1 -2 zeros(1,n-2)])  % constant on each diagonal

I=eye(4)   % identity matrix
J=ones(4)  % all ones, 4 by 4
triu(J)   % upper triangle
tril(J,1)   % lower triangle from 1st superdiagonal

R = rand(5)   % uniform random in [0,1]
S = randn(5)   % normally distributed (Gaussian)

x = 0:0.2:1   % specify step size
y = linspace(0,1,6)  % specify number of points

repmat(x,[3 1])   % repeat a matrix/vector
repmat(x,[1 2])   % repeat a matrix/vector
repmat(x',[1 2])   % repeat a matrix/vector (after transpose)

A = magic(4)
row2 = A(2,:)
rows2and3 = A(2:3,:)
rows2and3lastcolumn = A(2:3,end)

select = A(:,1) > 6   % logical selector
A(select,:)   % logical index

A(1,4) = -1   % change one element
A(1,:) = [1 2 3 4]  % change row
A(1,:) = [1 2 3 4]'  % wrong shape, works anyway!
A(:,2) = 0   % expand the scalar to apply to each element
A([2 4],:) = A([4 2],:)   % swap rows 2 and 4

A = magic(4)
A(1:7)    % linear index
A( A<6 )   % logical linear index
A( A<6 ) = NaN    % not a number
reshape(A,[2,8])    % interpret as a 2 by 8
reshape(A,[16,1])    % interpret as a vector
A(:)   % interpret as column vector
A(:) = 5   % everything becomes 5

A = magic(4)
B = repmat(1:4,[4 1])
A*A    % matrix multiplication
A .* B   % elementwise mult.
C = rand(2,4);   D = rand(2,4);
C*D    % error
C.*D  % legitimate, same size
A + B   % both interpretations the same
3*A   % scale each element
A^2   % matrix times itself
A.^2  % elementwise
C^2  % not defined
C.^2   % seems legit

C.^D   % elementwise power
B./A  % elementwise division
sin(pi*A)  % elementwise function
t = linspace(0,1,500);
y = t.^2*cos(t) - exp(t);  % evaluate expression at all points
y = t.^2*cos(t) - exp(t);  % forgot a dot

A = magic(4)
sum(A,1)  % column sums
sum(A,2)  % row sums
sum(diag(A))  % also 34
sum(diag(fliplr(A)))  % flip l to r
sum(diag(A(:,end:-1:1)))  % same effect

diff(A,1)   % diff along first dimension
diff(A,2)   % diff of a diff!
diff(A,[],2)   % insert empty matrix

min(A,2)   % not along the columns!
min(A,[],2)   % min along the columns
mean(A,1)  % average

A(2,:) = []   % delete second row


A = magic(4)
m = size(A,1)
v = (1:4)'
bsxfun(@times,A,v)   % automatically expand v to same size as A
V = repmat(v,[1 4]);  A.*V   % same effect
v = (1:4)'
u = (1:5)
bsxfun(@times,u,v)
bsxfun(@times,v,u)
bsxfun(@times,u',v')
u
bsxfun(@minus,u,u')   % all pairwise differences
