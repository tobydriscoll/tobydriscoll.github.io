% Show the power function that arises in error analysis

phi = @(e,r) max(1-e*r,0).^4.*(4*e*r+1);  % Wendland phi_{2,1}
%phi = @(e,r) exp(-(e*r).^2);   % Gaussian RBF

%% Parameters
ep = 2;   % shape
n = 100;  % number of nodes
ne = 50;   % points in each dim for evaluation grid
ctr = haltonseq(n,2);   % uniform centers/nodes

%% Evaluation grid
[Xe,Ye] = meshgrid( linspace(0,1,ne) );
xe = [Xe(:) Ye(:)];

%% RBF nuts and bolts
R = distmatrix(ctr,ctr);  % interpolation matrix
A = phi(ep,R);
R = distmatrix(xe,ctr);
B = phi(ep,R);

%% Compute power function at evaluation points
U = A\B';    % one cardinal function per row
Q = zeros(ne*ne,1);
for j = 1:length(Q)
  Q(j) = phi(ep,0) - B(j,:)*U(:,j);
end
powfun = reshape( real(sqrt(Q)), ne,ne );

%% Plot
figure, subplot(1,2,1)
surf(Xe,Ye,reshape(U(94,:),ne,ne))  % cardinal function
hold on
plot3(ctr(94,1),ctr(94,2),1,'wo')
plot3(ctr([1:93 95:n],1),ctr([1:93 95:n],2),zeros(n-1,1),'ko')
subplot(1,2,2)
surf(Xe,Ye,powfun,log10(powfun))
set(gca,'zsc','log'), colorbar
