% Demo of cross-validation used in a shape parameter study

%%
phi = @(e,r) sqrt(1+(e*r).^2);
%phi = @(e,r) exp(-(e*r).^2);

%%
% Exact function to sample
g = @franke2d;

%%
% Centers and samples
n = 200;
ctr = haltonseq(n,2);    
R = distmatrix(ctr,ctr);
z = g(ctr(:,1),ctr(:,2));  % samples

%%
% Shape parameters and error results
ep = logspace(-2,2,120);
E = zeros(n,length(ep));

for p = 1:length(ep)
  % Interpolation matrix
  A = phi(ep(p),R);
  Ainv = pinv(A);   % more stable algorithm than inv()
  E(:,p) = (Ainv*z) ./ diag(Ainv);  % cross-validation errors
end

%%
% Plot results 
clf, subplot(1,2,1)
surf(ep,1:n,log10(abs(E)))
shading interp, set(gca,'xscale','log')
xlabel('\epsilon'), ylabel('node index'), zlabel('CV error')
subplot(1,2,2)
loglog(ep,max(abs(E)),'.-')
xlabel('\epsilon'), ylabel('max CV error')