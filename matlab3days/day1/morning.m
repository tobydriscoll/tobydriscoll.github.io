%% Playing with census data
% Toby Driscoll, July 2014
clear, close all

%% Raw data
% Here is some data from the US census. It comes with matlab by default.
load census
who

%%
% We inspect the values of variables just be entering their names at the
% command line.
cdate

%%
pop

%%
% Matlab considers these variables to be vectors. They have the same size.
size(cdate)

%%
% We can put them side by side using square brackets.
both = [ cdate, pop ]

%%
% Matlab calls this a matrix. Most languages would call it an array. It has
% two columns.
size(both)

%%
% One of the first things you usually want to do with data is to look at it
% graphically. The plot command uses a pair of vectors to define points in
% the plane, and connects them with straight lines.
plot(cdate,pop)

%%
% It's usually better to show the actual individual values, since the lines
% in between are fictitious.
plot(cdate,pop,'o')

%%
% We can annotate the graph after it is made.
xlabel('year')
ylabel('population (millions)')
title('US Census population')

%% Simple analysis
% We can calculate basic facts about the data.
average_value = mean(pop)
standard_dev = std(pop)
median_value = median(pop)

%%
% Those aren't very helpful. Let's try finding the best-fit line to the
% data.
p = polyfit(cdate,pop,1)

%%
% These are the coefficients of a linear function--a polynomial of degree
% one. Matlab represents a polynomial as a vector of coefficients, from
% highest degree to constant term.
slope = p(1), intercept = p(2)

%%
% We'll compare the best fit line to the data. In order to add to a plot,
% use |hold on|.
hold on

%%
% The |polyval| command evaluates a polynomial at given points.
plot(cdate,polyval(p,cdate),'r')

%% Exponential analysis
% The linear fit is not very good. We expect that populations grow
% exponentially. Such a relationship is revealed by a log-linear graph.
clf
semilogy(cdate,pop)

%%
% There are two distinct eras of growth. Let's just fit the data since 1900.
mask = (cdate >= 1900);
p = polyfit( cdate(mask), log(pop(mask)), 1 );
hold on
plot( cdate(mask), exp(polyval(p,cdate(mask))), 'r' )

%%
% We can extrapolate to 2010.
pop2010 = exp( polyval(p,2010) )

%%
% The actual population was about 309 million. 


