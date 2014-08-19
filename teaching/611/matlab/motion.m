function A = motion(n,v)

p = ceil(abs(v));
b = [ ones(p+1,1)/(p+1); zeros(n-p-1,1) ];
e = [ 1/(p+1); zeros(n-1,1) ];
if v > 0
  A = toeplitz(e,b);
else
  A = toeplitz(b,e);
end