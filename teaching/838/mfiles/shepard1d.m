%% Demo of Shepard quasi-interpolation in 1D

N = 1000; ep = 0.05*N;
x = linspace(0,1,N)';
phi = @(e,r) exp(-(e*r).^2);
phi = @(e,r) max(1-e*r,0).^3.*(3*e*r+1);  % Wendland 1,1

R = distmatrix(x,x);
A = phi(ep,R);
sumphi = sum(A,2);  % sum of phi(||x-x_j||)
Psi = diag(1./sumphi)*A;

z = sin(4*x);
f = Psi*z;

close all, figure
subplot(1,2,1), plot(x,Psi(:,[3 N/2 N-3]),'.-')
title('Generating functions')
subplot(1,2,2), plot(x,z-f,'.')
