clear all
close all
% Input 
%u_a = 0.1 * 10^(2) ;
u_a = 0.01 * 10^(2) ;
u_spr =  10 * 10^(2) ;
n =1.37;
f = 200*10^8;
% Fact
c = 3*10^8/n ;

% Calculation
w=2*pi*f;
D = 1/(3*(u_a+u_spr));

k_r = sqrt(u_a/(2*D)*(sqrt(1+(w/(c*u_a))^2)-1));

k_i = sqrt(u_a/(2*D)*(sqrt(1+(w/(c*u_a))^2)+1));

k = k_r+k_i*1i;
A=10;
B=100;
u_eff = sqrt(u_a/D);

axis tight manual % this ensures that getframe() returns a consistent size
filename = 'HWOptic_11_19_Ver2.gif';

for t = 0:0.0001:0.05
      t =t*10^-8
      %[X,Y] = meshgrid(-0.002:0.00005:0.002,-0.002:0.00005:0.002);
      [X,Y] = meshgrid(-10:0.2:10,-10:0.2:10);
      X_m = X*10^-3
      Y_m = Y*10^-3
      r = sqrt(X_m.^2+Y_m.^2)+0.001;
      Z = abs((A.*exp(-u_eff.*r)+B.*exp(1i.*k.*r-1i.*w.*t))./(4.*pi.*c.*D.*r));
      surf(X,Y,log(Z)) 
      xlabel('X axis (mm)')
      ylabel('Y axis (mm)')
      zlim([-10,-2])
      zlabel('Log Amplitude')
      title('Propagation of a photon-density wave')
      % Capture the plot as an image 
      frame = getframe(gcf); 
      im = frame2im(frame); 
      [imind,cm] = rgb2ind(im,256); 
      % Write to the GIF File 
      if t == 0 
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf); 
      else 
          imwrite(imind,cm,filename,'gif','WriteMode','append'); 
      end
end