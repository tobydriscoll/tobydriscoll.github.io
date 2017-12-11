
format compact
[s,e,m] = ieee(1.0)

eps
[s,e,m] = ieee(1+eps)

R = (2.0^1023)*(1 + (2^52-1)/2^52)  % also called realmax
[s,e,m] = ieee(R)

2^1024

r = 2.0^-1022    % also called realmin
[s,e,m] = ieee(r)
