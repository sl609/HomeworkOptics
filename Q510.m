
angle=[-pi:0.01:pi];

gs=[0,0.1,0.5,0.9,0.99];

figure;
for i=1:length(gs) 
    g=gs(i)
    p=(1-g^2)./(2.*(1+g^2-2.*g.*cos(angle)));
    semilogy(angle,p)
    hold on
end
legend('g=0','g=0.1','g=0.5','g=0.9','g=0.99')
xlabel('angle (rad)')
ylabel('p(\theta)')