% Demo of greedy partial-solve algorithm
%%
phi = @(e,r) exp(-(e*r).^2);

%%
% Exact function to sample
g = @franke2d;

%%
% Nodes and samples
m = 16000;
node = haltonseq(m,2);  
z = g(node(:,1),node(:,2));  % samples

%% 
% Start with a random center set
n = 1;  % number of nodes in each partial solve
J = false(m,1);
index = ceil(m*rand(n,1));
J(index) = true;
ep = 5;

%% 
% Adaptive iteration
figure
c = zeros(m,1);
normr = [];
for k = 1:300
  R = distmatrix(node,node(J,:));
  A = phi(ep,R);
  cnew = A(J,:)\z(J);  % partial-set solution
  r = z-A*cnew;        % residual vector
  normr(k) = norm(r);

  % Update the total approximation
  c(J) = c(J) + cnew;

  % Find the largest residual.
  absr = abs(r);  
  [tmp,idx] = sort(absr,'descend');
  new = idx(1:n);
  J(:) = false;
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
