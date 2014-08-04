X = imread('lipid.bmp');
size(X)
X(100:110,100:105 )
image(X)
colorbar
colormap( gray(256) )
axis equal
eps
whos
X = double(X);
whos
8:-2:0
i = 1:4;  j = 1:6;
[I,J] = meshgrid(i,j)
i = 1:840;  j = 1:440;
[I,J] = meshgrid(i,j);
ii = 1:0.25:840;  jj = 1:0.25:440;
[II,JJ] = meshgrid(ii,jj);
size(I)
size(II)
XX = interp2( I,J,X, II,JJ, 'nearest' );
image(XX)
figure
XX = interp2( I,J,X, II,JJ, 'linear' );
image(XX)
colormap( gray(256) )
ax = axis
format
ax = axis
axis(ax)
figure
colormap( gray(256) )
XX = interp2( I,J,X, II,JJ, 'pchip' );
image(XX)
axis(ax)
clc
N = 512;  h = 2*pi/N;
x = (0:N-1)*h;
k = (0:N-1);
1i
y = sin(3*x) + cos(70*x) - exp(1i*100*x);
yhat = fft(y);
plot(k,abs(yhat),'o')
