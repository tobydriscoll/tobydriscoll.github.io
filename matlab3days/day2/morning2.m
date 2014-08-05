%% Arrays
% Toby Driscoll, July 2014
clear, close all, format short

%% 
% A table of numbers can be seen either as an array (accessed by
% multidimensional indices rather than a linear one) or a matrix (an array with
% special mathematical properties). MATLAB does not make a formal distinction,
% but there are functions and expressions for both points of view.

%% Elementwise operations
A = repmat( (1:6)', [1 5] )
B = tril( 2*ones(6,5) )

%%
% Arrays and matrices are added the same way. Scalar multiplication is the same
% too.
ApluB = A + B
Atimes3 = 3*A

%%
% However, multiplication is different. For these sizes, AB isn't even defined
% in the matrix sense. But if we just want to multiply corresponding elements,
% we have an operation.
AdottimesB = A.*B

%%
% Similarly, |A^2| is not defined, but |A.^2| is.
Apow2 = A.^2

%%
% We even have a valid...
ApowB = A.*B

%%
% Finally, as you might expect, we have elementwise division.
BoverA = B./A

%%
% Note that scalars are "expanded" into the correct size with these operations.
OneOverA = 1./A

%%
% Mathematical functions are also defined elementwise for vectors and
% (often) matrices. As a rule, if you want to evaluate an expression at
% many points at once, use array operations.
t = linspace(0,10,501);
plot( t, t.^2.*besselj(2,t) - cos(t) )

%% Reduction operations
% Anothey type of array function is to apply a vector function over and over to
% the rows or columns. For example:
colSumA = sum(A,1)
rowSumA = sum(A,2)

%%
% Note how the dimension is lowered by one, and the shape is different depending
% on the direction in which the operation is done. 

%%
% The functions |mean|, |std|, |max|, |min|, and |diff| all behave this way
% too. However, sometimes the dimension argument is the third, not the
% second.
min(A,2)      % whoops
min(A,[],2)   % yay

%% bsxfun
% Sometimes you want to apply an operation to each column or row, but with
% different numbers. The function |bsxfun| applies any binary operation, first
% replicating any argument along a singleton dimension.

%%
% For example, if we want to multiply each row of A by the its row number,
% we enter
m = size(A,1);   % number of rows
bsxfun( @times, A, (1:m)' )

%%
% A common scenario is to find all the pairwise differences of elements in
% two vectors, which bsxfun makes easy.
x = (1:5);
y = (10:10:60);
allXMinusY = bsxfun( @minus, x, y' )

%%
% Carefully study why this result is different:
bsxfun( @minus, x', y )
