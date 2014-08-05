%% Elimination
% Toby Driscoll, July 2014
clear, close all

%%
% Let's walk through Gaussian elimination for a particular linear system of
% equations. 
A = [ 2 1 1 0; 4 3 3 1; 8 7 9 5; 6 7 9 8 ]
b = [ 4; 9; 17; 12];

%%
% First make the augmented matrix.
Ab = [ A, b ];

%%
% Use the first row to eliminate nonzeros from the first column.
Ab(2,:) = Ab(2,:) - 2*Ab(1,:);
Ab(3,:) = Ab(3,:) - 4*Ab(1,:);
Ab(4,:) = Ab(4,:) - 3*Ab(1,:)

%%
% Now repeat for the second row and column.
Ab(3,:) = Ab(3,:) - 3*Ab(2,:);
Ab(4,:) = Ab(4,:) - 4*Ab(2,:)

%%
% One more time and we get a triangular structure.
Ab(4,:) = Ab(4,:) - Ab(3,:)

%%
% Now we can solve for $x_4$ immediately:
x(4,1) = Ab(4,5) / Ab(4,4);

%%
% We can walk up the rows from there.
x(3) = (Ab(3,5) - Ab(3,4)*x(4)) / Ab(3,3);
x(2) = (Ab(2,5) - Ab(2,4)*x(4) - Ab(2,3)*x(3)) / Ab(2,2);
x(1) = (Ab(1,5) - Ab(1,4)*x(4) - Ab(1,3)*x(3) - Ab(1,2)*x(2)) / Ab(1,1);

%% Automation
% Surely we can automate this! Let's start with the solution part at the
% end.
x(4,1) = Ab(4,5) / Ab(4,4);

%%
% We see some inner products in the steps that follow.
x(3) = (Ab(3,5) - Ab(3,4)*x(4)) / Ab(3,3);
x(2) = (Ab(2,5) - Ab(2,3:4)*x(3:4)) / Ab(2,2);
x(1) = (Ab(1,5) - Ab(1,2:4)*x(2:4)) / Ab(1,1);

%%
% Could it work to write this in a loop?
n = 4;
for i = n:-1:1
    x(i,1) = (Ab(i,n+1) - Ab(i,i+1:n)*x(i+1:n)) / Ab(i,i);
end

%%
% The other part can be automated too. We'll skip the details and rely on
% MATLAB for it.
[L,U,P] = lu(A)

%%
% The |lu| command finds three matrices such that $PA = LU$, where $PA$ is a
% permutation of the rows of $A$, and $L$ and $U$ are triangular. It's not
% obvious why this is equivalent to Gaussian elimination, but it is. 

%%
% Now, if $Ax=b$, then $PAx=Pb$ and $L(Ux)=Pb$. So we do a forward
% substitution to find $Ux$, and then a backward substitution to find $x$.
% There are shortcuts for these steps too.
z = L \ (P*b);
x = U \ z

%%
% Hmm, we seem to have gotten a different expression. 
x - round(x)

%%
% This is very close to a tiny error caused by roundoff, of size
eps

%%
% In general, we cannot expect answers to be any more accurate (in a
% relative sense) than eps. In fact, sometimes they are much less accurate,
% as explained in numerical analysis.

%% Backslash
% The backslash we used for triangular solves can in fact be used for the
% original system, $Ax=b$.
x = A \ b

%%
% This performs a factorization and two triangular solves automatically.
% The expression |A\| is the mathematical equivalent of $A^{-1}$ multiplied
% on the left. However, in computation we never use the inverse, because
% doing so is much slower. 

%% Eigenvalues
% Next to solving linear systems, the second most common task in linear
% algebra is to find the eigenvalues of a square matrix.
A = magic(4)

%%
[V,D] = eig(A)

%%
% If the matrix is diagonalizable, we find that $A=VDV^{-1}$. Remember, we
% never use a matrix inverse. To get an inverse from the right, use |/|.
V * D / V

%%
% Here is a Jordan block. It has one distinct eigenvalue.
J = toeplitz([1 0 0 0 0],[1 1 0 0 0])

%%
[V,D] = eig(J);
eigval = diag(D)

%%
% We now get the wrong result for $VDV^{-1}$. 
V * D / V

%%
% The reason is that $V$ is singular. All the columns are multiples of the
% first.
V

%%
% However, it is still true that $JV=VD$.
norm( J*V - V*D )