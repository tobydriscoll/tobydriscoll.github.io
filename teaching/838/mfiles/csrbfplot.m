% Plots of compactly supported Wendland radial functions

subplot(2,2,1)
phi = @(r) max(1-r,0).^2;
fplot(phi,[0 1.2]), ylim([-.1 1.1])
title('C^0 smooth')
subplot(2,2,2)
phi = @(r) max(1-r,0).^4.*(4*r+1);
fplot(phi,[0 1.2]), ylim([-.1 1.1])
title('C^2 smooth')
subplot(2,2,3)
phi = @(r) max(1-r,0).^6.*polyval([35 18 3]/3,r);
fplot(phi,[0 1.2]), ylim([-.1 1.1])
title('C^4 smooth')
subplot(2,2,4)
phi = @(r) max(1-r,0).^8.*polyval([32 25 8 1],r);
fplot(phi,[0 1.2]), ylim([-.1 1.1])
title('C^6 smooth')

