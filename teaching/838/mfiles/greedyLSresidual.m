% Demo of greedy least-squares algorithm
%%
phi = @(e,r) sqrt(1+(e*r).^2);
%phi = @(e,r) exp(-(e*r).^2);

%%
% Exact function to sample
g = @franke2d;

%%
% Nodes and samples
m = 1000;
node = haltonseq(m,2);  
z = g(node(:,1),node(:,2));  % samples

%% 
% Start with a random center set
J = false(m,1);
index = ceil(m*rand(20,1));
J(index) = true;
n = 20;
ep = 5;

%% 
% Adaptive iteration
figure
c = zeros(m,1);
normr = [];
for k = 1:10
  R = distmatrix(node,node(J,:));
  A = phi(ep,R);
  cnew = A\z;     % least-squares solution
  r = z-A*cnew;   % residual vector
  normr(k) = norm(r); norm(cnew)

  % Update the total approximation
  c(J) = c(J) + cnew;

  % Find the largest residuals from the inactive set. (Trick: reset the 
  % active ones so that they are not eligible.)
  absr = abs(r);  absr(J) = -Inf;
  [tmp,idx] = sort(absr,'descend');
  new = idx(1:5);
  J(new) = true;
  
  % Next pass approximates current residual
  z = r;
  
  % Plot
%   clf, plot3(node(:,1),node(:,2),r,'k.')
%   hold on, plot3(node(J,1),node(J,2),r(J),'bo')
%   plot3(node(new,1),node(new,2),r(new),'r*')
%   title(sprintf('iteration #%i',k))
%   pause
end
