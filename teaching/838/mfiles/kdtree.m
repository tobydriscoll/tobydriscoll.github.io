function t = kdtree(points)

t = subtree(points,1:size(points,1),1);

end

function t = subtree(points,data,dim)

n = size(points,1);
if n==0
  t = [];
elseif n==1
  t.point = points;
  t.data = data;
  t.dim = dim;
  t.left = [];
  t.right = [];
else
  % Find median in dimension dim.
  [s,idx] = sort(points(:,dim));
  n2 = ceil(n/2);
  k = idx(n2);
  t.point = points(k,:);
  t.data = data(k);
  t.dim = dim;
  dim = rem(dim,size(points,2)) + 1;
  j = idx(1:n2-1);
  t.left = subtree(points(j,:),data(j),dim);
  j = idx(n2+1:n);
  t.right = subtree(points(j,:),data(j),dim);
end

end
