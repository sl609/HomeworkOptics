% Example 12.9

% Photoacoustic signal from a homogeneously heated sphere
% Use SI units

clear all
vs = 1500;
p0 = 1;
Rs = 0.5E-3;
rmax = 4;
rmin = 1E-3*Rs;
r = linspace(0, rmax*Rs, 1000) + rmin;
dr = rmax*Rs/(1000-1);

theta = linspace(-pi/2, pi/2);
filename = 'HWOptic12_11.gif';
h=figure;
clf

i_axis = 1;
for t = [0:0.1:5]*Rs/vs
    pin1 = p0/2*(1+vs*t./r).*heaviside(r+vs*t).*heaviside(Rs-r-vs*t);
    pinr = p0/2*(1-vs*t./r).*heaviside(-r+vs*t).*heaviside(Rs+r-vs*t);
    pout = p0/2*(1-vs*t./r).*heaviside(r-vs*t).*heaviside(Rs-r+vs*t);
    p = pin1 + pinr + pout;

    subplot(1, 2, 1, 'align')
    hold off;
    plot(r/Rs, pin1/p0, 'k--', ...
    r/Rs, pinr/p0, 'k-.', ...
    r/Rs, pout/p0, 'k-', ...
    cos(theta), sin(theta), 'k-')
    tick = [.015 .025];
    set(0,'DefaultAxesTickLength',tick)
    title(['t = ', num2str(vs*t/Rs), 'x\itR_s/v_s'])
    axis equal;
    axis([0, rmax, -2, 2])
    ylabel('Partial pressures/\itp\rm_0')
    xlabel('\itr/R_s')
     legend('p_{in1}', 'p_{inr}', 'p_{out}') 
    subplot(1, 2, 2, 'align')
    hold off;
    plot(r/Rs, p/p0, 'k-', ...
    cos(theta), sin(theta), 'k-')
    tick = [.015 .025];
    set(0,'DefaultAxesTickLength',tick)
    title(['t = ', num2str(vs*t/Rs), 'x\itR_s/v_s'])
    axis equal;
    axis([0, rmax, -2, 2])
    ylabel('Total pressure/\itp\rm_0')
    xlabel('\itr/R_s')
    frame = getframe(h); 
    im = frame2im(frame); 
    [imind,cm] = rgb2ind(im,256); 
    % Write to the GIF File 
    if t == 0 
    imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
    else 
    imwrite(imind,cm,filename,'gif','WriteMode','append'); 
    end
end
