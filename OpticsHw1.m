
x=0:0.001:10;

y=exp(-x);

figure
plot(x,y*100)
xticklabels({'0','1\\\mu_{a}','2\\\mu_{a}','3\\\mu_{a}','4\\\mu_{a}','5\\\mu_{a}','6\\\mu_{a}','7\\\mu_{a}','8\\\mu_{a}','9\\\mu_{a}','10\\\mu_{a}'})
ylabel('Percentage of left light')
xlabel('Length (L)')

