function F = franke2d(x,y)
% FRANKE2D Franke's test function of two variables.
% FRANKE2D(X,Y) is typically evaluated over [0,1]^2.

F = 0.75*exp( -((9*x-2).^2+(9*y-2).^2)/4 );
F = F + 0.75*exp( -(9*x+1).^2/49 - (9*y+1).^2/10 );
F = F + 0.5*exp( -((9*x-7).^2+(9*y-3).^2)/4 );
F = F - 0.2*exp( -((9*x-4).^2+(9*y-7).^2));