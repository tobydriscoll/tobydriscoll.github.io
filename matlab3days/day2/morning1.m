%% Making matrices
% Toby Driscoll, July 2014
clear, close all

%% 
% Suppose we want to construct the $n\times n$ matrix whose $(i,j)$ entry
% is 1 if $i=j$, $-2$ if $|i-j|=1$, and zero otherwise. 
%%
% We're always free to type in the elements one by one.
A = [ 1 -2 0 0 0 0 0;
      0 1 -2 1 0 0 0;
      0 0 1 -2 1 0 0;
      0 0 0 1 -2 1 0;
      0 0 0 0 1 -2 1;
      0 0 0 0 0 1 -2 ]
  
%%
% What a drag. And what if $n=1000$...?

%% Loops
% Here's an easy method for any size, using a pair of nested loops.
n = 7;
for i = 1:n
    for j = 1:n
        if i==j
            A(i,j) = 1;
        elseif abs(i-j)==1
            A(i,j) = -2;
        else
            A(i,j) = 0;
        end
    end
end
A

%%
% That's straightforward but not exactly compact. You could do better in
% this case with just one loop, filling in just the nonzeros. 
n = 7;
A = zeros(n);   % start with all zero n by n
A(1,1) = 1;  A(1,2) = -2;
for i = 2:n-1
    A(i,i) = 1;
    A(i,i-1) = -2;
    A(i,i+1) = -2;
end
A(n,n-1) = -2;  A(n,n) = 1;
A

%%
% We could even shorten the lines inside the loop to
% |A(i,i-1:i+1)=[-2,1,-2]|. 

%% No loops
% Note, however, that $A$ is easily described in terms of its diagonals. By
% using the |diag| command, it's easy to construct it with no loops at
% all.
A = diag(ones(1,n)) + diag(-2*ones(1,n-1),1) + diag(-2*ones(1,n-1),-1)

%%
% Easiest of all is if you know that a matrix defined by
% $a_{i,j}=a_{i-j}$ is called a Toeplitz matrix, and there is a command for
% building them. 
A = toeplitz( [1 -2 zeros(1,n-2) ] )

%% Other 'atomic' operations
% In addition to |zeros|, |diag|, and |toeplitz|, there are other commands
% to make common matrix building blocks without loops.
I = eye(5)
J = ones(5)

%%
U = triu(J)
L = tril(J,1)

%%
R = rand(5)      % uniform random in [0,1]
N = randn(5)     % normal random

%%
x = 0:0.2:1             % equally spaced with given spacing
y = linspace(0,1,6)     % equally spaced with given number

%%
xtrans = x'             % transpose

%%
R = repmat(x',[1 3])    % copy some matrix over and over


%% Indexing
% The rows and columns of a matrix can be selected either by "direct"
% reference to the desired indices, or by "logical" indexes. 
A = magic(4)

%%
rows2and3 = A(2:3,:)
lastColumn = A(:,end)
oddRowsInColumn2 = A( logical([1 0 1 0]), 2 )

%%
% In addition, every matrix is really stored as a linearly addressed block
% of memory. You can use a linear index instead.
first7 = A( 1:7 )
biggerThan6 = A( A>6 )

%%
% You can explicitly reshape a matrix as long as the number of elements
% doesn't change. 
twoByEight = reshape(A,[2 8])
vectorForm = reshape(A,[numel(A) 1])

%%
% The last statement is also found by using |A(:)|. 

%%
% Note that assignment is also possible with the same syntax.
A([2 3],:) = A([3 2],:)   % swap rows

%%
A( A<5 ) = NaN    % assign scalar to each




