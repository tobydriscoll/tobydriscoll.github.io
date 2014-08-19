function A = blur(n,c)

thresh = 1e-4;
x = (0:n-1)';
col = exp( -x.^2/(2*c^2) ) / (c*sqrt(2*pi));
col(col<thresh) = 0;
A = toeplitz(col);

end