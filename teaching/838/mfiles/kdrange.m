function list = kdrange(x,r,t)

visits = 0;
list = [];
stack = {t}; 
top = 1;
while top>0
  t = stack{top};  top = top-1;
  if isempty(t), continue, end
  visits = visits+1;
  dist2 = sum( (x - t.point).^2 );
  if dist2 < r^2
    list = [list t.data ];
  end
  dim = t.dim;
  if x(dim)-r <= t.point(dim)
    top = top+1;
    stack{top} = t.left;
  end
  if x(dim)+r >= t.point(dim)
    top = top+1;
    stack{top} = t.right;
  end
end

visits

end

