function [x,P] = powerfunctionopt(n)

% Power function optimization

ep = .5;   % shape
phi = @(r) max(1-ep*r,0).^3.*(3*ep*r+1);  % Wendland phi_{1,1}
%phi = @(r) exp(-(ep*r).^2);   % Gaussian RBF
phi = @(r) 1./(1+(ep*r).^2);

xe = linspace(-1,1,600)';

%
% Initial nodes
x = linspace(0,1,n)';
u = log(diff(x(1:n-1)));
P = powerfun(u);
scale = norm(P);

opt = optimset('disp','iter');
u = lsqnonlin(@(u) powerfun(u)/scale,u,[],[],opt);
u1 = cumsum(exp(u));
x = [-1; -u1(end:-1:1); 0; u1 ; 1];
P = powerfun(u);


  function P = powerfun(u)
    u1 = cumsum(exp(u));
    x = [-1; -u1(end:-1:1); 0; u1 ; 1];
    R = distmatrix(x,x);  % interpolation matrix
    A = phi(R);
    R = distmatrix(xe,x);
    B = phi(R);
    
    % Compute power function at evaluation points
    U = A\B';    % one cardinal function per row
    Q = zeros(size(xe));
    for j = 1:length(Q)
      Q(j) = phi(0) - B(j,:)*U(:,j);
    end
    P = real(sqrt(Q));
  end

end