clear all
% Input
u_a = 0.1 * 10^(2) ;
u_spr =  10 * 10^(2) ;
n =1.37;

% Fact
c = 3*10^8/1.37 ;

% Calculation

resolution = 1000;
freq=linspace(100,1000,resolution);

lamda_list = [];
k_i_list = [];

for i = 1:resolution
    
    f = freq(i)*10^6;
    
    w=2*pi*f;
    
    D = 1/(3*(u_a+u_spr));

    k_r = sqrt(u_a/(2*D)*(sqrt(1+(w/(c*u_a))^2)-1));

    k_i = sqrt(u_a/(2*D)*(sqrt(1+(w/(c*u_a))^2)+1));
    
    k_i_list = [k_i_list,k_i];

    lamda = 2*pi/k_r;
    
    lamda_list =[lamda_list,lamda*10^2];

end

figure;
plot(freq,lamda_list)
xlabel('Frequency (MHz)')
ylabel('Wavelength (cm)')
title('Wavelength')
figure;
plot(freq,k_i_list)
xlabel('Frequency (MHz)')
ylabel('k_{i}')
title('k_{i}')