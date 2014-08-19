load census
pathtool
which census
help load
doc load
who
clc
cdate
cdate'
size(cdate)
pop
size(pop)
both = [ cdate, pop ]
pop(1) = 0;
both
clc
load census
plot(cdate,pop)
set(0,'defaultaxesfontsize',18)
set(0,'defaultlinelinewidth',2)
plot(cdate,pop)
plot(cdate,pop,'o')
plot(cdate,pop,'s')
plot(cdate,pop,'s-')
xlim([1790 1990])
shg
xlabel('year')
ylabel('population (millions)')
title('US Census Data, 1790-1990')
saveas(1,'census.png')
pwd
cd ~/Dropbox/class/intromatlab/3days
saveas(1,'census.fig')
open census.fig
print -depsc census.eps
print -r300 -depsc census.eps
clc
pop
mean(pop)
median(pop)
std(pop)
sum(pop)
clc
p = polyfit(cdate,pop,1)
slope=p(1)
polyval(p,2000)
plot(cdate,pop,'s-')
figure
plot(cdate,pop,'s-')
hold on
t = linspace(1790,2000,501);
size(t)
plot( t, polyval(p,t), 'r' )
legend('data','linear fit')
p(1)
p(2)
plot(cdate,pop,'s-')
semilogy( cdate, pop, 's-')
axis tight
select = (cdate >= 1900)
size(select)
select = (cdate >= 1900);
cdate(select)
p = polyfit(cdate(select),log(pop(select)),1)
hold on
t = linspace(1990,2000,501);
t = linspace(1900,2000,501);
plot(t,polyval(p,t),'r')
plot(t,exp(polyval(p,t)),'r')
polyval(p,2000)
exp(ans)
