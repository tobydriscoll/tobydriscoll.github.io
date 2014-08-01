function morning

%% Scripts and functions
% Toby Driscoll, July 2014
clear, close all

%% Scripts
% A script is simply a list of MATLAB commands that go in a text file. When
% it is run, the effect is exactly the same as if those commands had been
% typed in.

%%
% In order to be run, the script is saved as an "M-file", as in
% "myscript.m". The folder/directory where the file is saved must be on
% MATLAB's path. Then the name of the file is typed in at the command line,
% e.g., "myscript", to run the script.

%%
% Scripts are a good way to gather a medium set of commands that you need
% to try again and again to experiment or debug. They are also useful to
% create documents like this one, using the |publish| facility.

%% Functions
% Like scripts, functions are collections of MATLAB commands, saved as a
% text file with the extension "*.m". However, they behave quite
% differently. 

%%
% Each function gets its own variable workspace. The function knows nothing
% of variables that were defined outside of it, and its variables cannot be
% seen from the command line (the "base" workspace) or from other
% functions. This setup means that you can use common variable names, like
% |x|, knowing that you won't come into conflict with the same variable
% names elsewhere.

%%
% In order to communicate with other variable workspaces, functions have
% input and output arguments. These are declared in the first line of the
% function. For example,

function [r1,r2] = quadform(a,b,c)
  D = sqrt(b^2-4*a*c);
  r1 = (-b+D)/(2*a);
  r2 = (-b-D)/(2*a);
end

%%
% The first line says that whatever invokes the function is supposed to
% provide three values, which the function defines by the names |a|, |b|,
% and |c|. At the end of the function, two values will be returned to the
% caller: the values held by |r1| and |r2| when the function ends. 

%%
% The function and the caller do not have to use the same names for the
% arguments. In fact, they may not have names at all in the caller:
[x1,x2] = quadform(1,-2,3)

%%
% Note that executing the function created no variables that we have access
% to.
b_exists = exist('b')

%% Lambda functions (anonymous functions)
% Sometimes you want to create a short function without writing a file for
% it. There is a mechanism that MATLAB calls anonymous functions (and the
% rest of the world's languages call lambda functions) for this. For
% example:

sincos = @(x) sin(x).*cos(x)

%%
sincos(pi/4)

%%
% These functions can take more than one input argument, but cannot return
% more than one output, and they must consist of a single expression (not
% multiple lines).

%%
% One common way to use these functions is to create a "wrapper". For
% example, suppose we want to use |interp1| to create a function from data 
% that can be called multiple times. We can use the full syntax of |interp1|
% each time, of course.
cdate = []; pop = [];
load census
interp1(cdate,pop,1995,'pchip')
interp1(cdate,pop,1996,'pchip')

%%
% But this requires computation of the interpolant's parameters every time.
% There is an alternate output type to help avoid this problem. 
pp = interp1(cdate,pop,'pchip','pp');

%%
% Now we can use |ppval| to evaluate much faster.
ppval(pp,1995)
ppval(pp,1996)

%%
% However, this lacks elegance and requires you to pass around the |pp|
% variable and remember what it's for. Instead, we can create a proper,
% callable function.
f = @(x) ppval(pp,x)
f(1995)
f(1996)

%%
% If you pass |f| into another function, it will remain callable, even if
% you don't pass in the |pp| data. In other words, the definition of |f| is
% "closed" or self-contained. 

function y = greatyear(f)
    y = f(1987);
end

%%
greatyear(f)

%% Subfunctions and nested functions.
% If you have one function that relies on other helper functions to do its
% job, you can put them all in one file. The file name should match that of
% the first function. That function is the only one that will be visible
% and callable from outside the function, but the main function and
% subfunctions can all see each other. 

%%
% function mainfunc(x,y)
%
%   ... 
%
% end
%
% function w = helperfunc(z)
%
%   ... 
%
% end

%%
% Nested functions are trickier. They are defined in a nested fashion.

%%
% function mainfunc(x,y)
%
%   ...
%
%     function w = helperfunc(z)
%
%       ...
%
%     end
%
% end

%%
% Now helperfunc is still callable from within mainfunc, and not from
% outide the file. But there is a big difference. Any variable name that is
% used inside both the child function and its parent are the same variable.
% This aspect of nested functions violates the private workspace principle
% and should be used cautiously, but sometimes it is much more convenient
% than any alternative.

end


