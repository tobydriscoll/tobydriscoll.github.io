function list = kdrange(x,r,t)

global visits
visits = 0;
list = kdrangesub(x,r,t,[]);

end

function list = kdrangesub(x,r,t,list)

if isempty(t), return, end
global visits
visits = visits+1;
dist2 = sum( (x - t.point).^2 );
if dist2 < r^2
  list = [list t.data ];
end
dim = t.dim;
if x(dim)-r <= t.point(dim)
  list = kdrangesub(x,r,t.left,list);
end
if x(dim)+r >= t.point(dim)
  list = kdrangesub(x,r,t.right,list);
end

end
  