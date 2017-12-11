
year = (1955:5:2000)';
anomaly = [ -0.0480; -0.0180; -0.0360; -0.0120; -0.0040; 0.1180; 0.2100; 0.3320; 0.3340; 0.4560 ];
plot(year,anomaly,'o')

t = year-1955;
m = length(t)

A = t.^0;
for j = 1:m-1
    A = [A,t.^j];
end
b = anomaly;

c = A\b;   % coefficients, from degree 0 to m-1

p = @(x) polyval(c(end:-1:1),x-1955);  % interpolating polynomial
plot(year,anomaly,'o')
hold on
fplot(p,[1955 2000])
title('World temperature anomaly')
xlabel('year'), ylabel('anomaly (deg C)')

A = A(:,1:4);
size(A)

c = A\b;   % coefficients, from degree 0 to 3

p = @(x) polyval(c(end:-1:1),x-1955);  % fitting polynomial
plot(year,anomaly,'o')
hold on
fplot(p,[1955 2000])
title('World temperature anomaly')
xlabel('year'), ylabel('anomaly (deg C)')

B = A'*A;  z = A'*b;
size(B)

format short e, format compact
[c B\z]

[Q,R] = qr(A,0);  z = Q'*b;
[c R\z]

[U,S,V] = svd(A,0);  z = U'*b;
[c V*(z./diag(S))]
