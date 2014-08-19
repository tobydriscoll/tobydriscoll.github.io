function U = distmatrixcs(node,center,support)
% DISTMATRIXCS Distance matrix using finite support radius.
% U = DISTMATRIX(NODE,CENTER,SPRT) finds the matrix U given as
%
%   U(i,j) = 1 - dist(NODE(i,:),CENTER(j,:))/SPRT,
%
% where dist() represents Euclidean distance. However, negative results 
% (i.e., distances greater than SPRT) are not stored, and the resulting 
% matrix is sparse.

m = size(node,1);
n = size(center,1);

% Preallocate space for the values and indices of nonzeros in the matrix.
row = zeros(60*m,1);
col = row;
val = row;
last = 0;

% Compute values and locations of nonzeros, row by row.
% This version is more efficient for n>m. If m>n, the loop should go over
% columns, with distances computed for one center at a time to all nodes.
for i = 1:m
  dx = bsxfun(@minus,node(i,:),center);  % from node to each center
  dist = sqrt( sum(dx.^2,2) );           % compute dist in each case
  idx = find( dist<support );            % which are close enough?
  k = length(idx);                       % how many there are
  row(last+(1:k)) = i;                   % all go in row i...
  col(last+(1:k)) = idx;                 % ..and with these centers...
  val(last+(1:k)) = 1-dist(idx)/support; % ...with these values
  last = last+k;
  if last>60*m, 
    error('Too large!')
  end
end
  
% Assemble the sparse matrix.
U = sparse( row(1:last), col(1:last), val(1:last), m, n );

end