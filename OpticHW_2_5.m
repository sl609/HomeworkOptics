% Rayleigh scattering Plot

diameter=1e-9;
radius=diameter/2;
lambda=1e-9;
n_sphere=1.57;
n_background=1.33;
w_sphere=1.05*1e-3/(1e-2)^3;
w_background=1.0*1e-3/(1e-2)^3;
concentration=1e-5;

k=2*pi*n_background/lambda;
x=k*radius;
n_rel=n_sphere/n_background;

polarizability = (n_rel^2 - 1)/(n_rel^2 + 2)*radius^3;


angle=[0:0.001:3*pi];

I=(1*k^4*(abs(polarizability))^2/(2*radius^2)).*(1+cos(angle).^2)

plot(angle,I)
xlabel('Angle (rad)');ylabel('Intensity')







