function [R,DX] = distmatrix(node,center)
% DISTMATRIX Distance matrix in arbitrary dimension.
% R = DISTMATRIX(NODE,CENTER) finds the matrix R given as
%
%   R(i,j) = dist( NODE(i,:), CENTER(j,:) ),
%
% where dist() represents Euclidean distance. 
%
% [R,DX] = DISTMATRIX(...) also returns pairwise differences of all
% coordinate values. Specifically, DX(i,j,d) is equal to
% node(i,d)-center(j,d). 

R = 0;
m = size(node,1);
n = size(center,1);
s = size(node,2);
if nargout > 1, DX = zeros(m,n,s); end
for d = 1:s
  dx = repmat(node(:,d),[1 n]) - repmat(center(:,d)',[m 1]);
  R = R + dx.^2;
  if nargout > 1, DX(:,:,d) = dx; end
end
R = sqrt(R);