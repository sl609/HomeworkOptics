% Example 12.8

% Photoacoustic signal from a homogeneously heated sphere
% Use SI units

clear all

vs = 1500;
p0 = 1;
Rs = 0.5E-3;

rd = 2*Rs; % Location of detector
t = linspace(0, (rd + 2*Rs)/vs, 1000);

figure(1)
clf

pin1 = p0/2*(1+vs*t./rd).*heaviside(rd+vs*t).*heaviside(Rs-rd-vs*t);
pinr = p0/2*(1-vs*t./rd).*heaviside(-rd+vs*t).*heaviside(Rs+rd-vs*t);
pout = p0/2*(1-vs*t./rd).*heaviside(rd-vs*t).*heaviside(Rs-rd+vs*t);
p = pin1 + pinr + pout;

plot(vs*t/Rs, p, 'k')
tick = [.015 .025];
set(0,'DefaultAxesTickLength',tick)
xlabel('Normalized time: \itv_s t\rm/\itR_s')
ylabel('Normalized pressure: \itp\rm/\itp\rm_0')
title('Pressure at \itr \rm= 2\itR_s')


Fs = 1000;            % Sampling frequency                    
T = 1/Fs;             % Sampling period       
L = 1500;             % Length of signal
t = (0:L-1)*T;        % Time vector

Y = fft(p);

Pcomplex=fftshift((Y/L));
P = fftshift(abs(Y/L));


df = Fs/length(Y);
f = -Fs/2+df:df:Fs/2;
figure;
plot(f,P) 
title('Fourier transform of pressure distribution')
xlabel('f (Hz)')
ylabel('|P1(f)|')

